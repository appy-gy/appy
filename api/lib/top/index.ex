defmodule Top.Index do
  alias Top.Repo
  import Ecto.Query, only: [from: 1, from: 2]
  import Tirexs.Mapping

  def index_name(index) do
    "#{Application.get_env(:top, __MODULE__)[:prefix]}_#{index}"
  end

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__), only: [define: 2, load: 1]

      def index_name do
        unquote(__MODULE__).index_name(@index)
      end
    end
  end

  defmacro define([type: type], [do: block]) do
    quote do
      var!(index) = [index: unquote(__MODULE__).index_name(@index), type: unquote(type)]
      mappings do: unquote(block)
      create_resource var!(index)
    end
  end

  def load(records) do
    records
    |> elem(5)
    |> Enum.group_by(&(&1._type))
    |> Enum.map(&fetch/1)
    |> List.flatten
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
end
