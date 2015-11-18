defmodule Top.Index do
  import Ecto.Query, only: [from: 1, from: 2]
  import Tirexs.Mapping

  def index_name(index) do
    "#{Application.get_env(:top, Top.Index)[:prefix]}_#{index}"
  end

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__), only: [define: 2, load: 2]

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

  def load(model, records) do
    ids = records |> elem(5) |> Enum.map(&(&1._id))
    from r in model, where: r.id in ^ids
  end
end
