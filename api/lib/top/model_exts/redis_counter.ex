defmodule Top.RedisCounter do
  def key_for(model_name, name, record) do
    "#{model_name}:#{record.id}:#{name}"
  end

  defmacro counter(name) do
    quote do
      def unquote(:"#{name}_count")(record) do
        key = unquote(__MODULE__).key_for(model_name, unquote(name), record)
        case Exredis.Api.get key do
          :undefined -> 0
          value -> value |> Integer.parse |> elem(0)
        end
      end

      def unquote(:"#{name}_increment")(record) do
        key = unquote(__MODULE__).key_for(model_name, unquote(name), record)
        Exredis.Api.incr key
      end
    end
  end
end
