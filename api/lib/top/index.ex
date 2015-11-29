defmodule Top.Index do
  alias Top.Repo
  alias Tirexs.Query
  alias Tirexs.Manage
  import Ecto.Query, only: [from: 1, from: 2]
  import Tirexs.Mapping

  @settings Tirexs.ElasticSearch.config

  def index_name(index) do
    "#{Application.get_env(:top, __MODULE__)[:prefix]}_#{index}"
  end

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__), only: [define: 2, load: 1]

      Module.register_attribute __MODULE__, :type_fields, accumulate: true

      @before_compile unquote(__MODULE__)

      def index_name do
        unquote(__MODULE__).index_name(@index)
      end

      def update(record) do
        unquote(__MODULE__).update(__MODULE__, record)
      end
    end
  end

  defmacro __before_compile__(_) do
    quote do
      def type_fields, do: @type_fields
    end
  end

  defmacro define([type: type], [do: block]) do
    fields = fields_in block

    quote do
      @type_fields {unquote(String.to_atom(type)), unquote(fields)}
      var!(index) = [index: unquote(__MODULE__).index_name(@index), type: unquote(type)]
      mappings do: unquote(block)
      create_resource var!(index)
    end
  end

  def update(index, record) do
    type = record.__struct__.model_name
    doc = Enum.reduce index.type_fields[type], [], &(Dict.put &2, &1, Map.get(record, &1))
    options = [index: index.index_name, type: Atom.to_string(type), id: record.id]
    Manage.update options, [doc: doc, doc_as_upsert: true], @settings
  end

  def load(records) do
    records
    |> Query.create_resource
    |> elem(5)
    |> Enum.group_by(&(&1._type))
    |> Enum.flat_map(&fetch/1)
    |> Enum.sort_by(fn {_, score} -> -score end)
    |> Enum.map(fn {record, _} -> record end)
  end

  defp fetch({name, records}) do
    model = Module.concat Top, Mix.Utils.camelize(name)
    ids = Enum.map records, &(&1._id)
    scores = Enum.reduce(records, %{}, &(Dict.put &2, &1._id, &1._score))
    query = from r in model, where: r.id in ^ids
    query |> Repo.all |> Enum.map(&({&1, scores[&1.id]}))
  end

  defp fields_in({:__block__, _, indexes}), do: Enum.flat_map(indexes, &fields_in/1)
  defp fields_in({:indexes, _, [field, _]}), do: [String.to_atom(field)]
end
