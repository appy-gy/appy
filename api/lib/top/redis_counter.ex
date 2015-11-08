defmodule Top.RedisCounter do
  defmacro counter(name) do
    import Top.ModelName

    quote do
      def unquote(:"#{name}_count")(record) do
        key = "#{model_name(__MODULE__)}:#{record.id}:#{unquote(name)}"
        case Exredis.Api.get key do
          :undefined -> 0
          value -> value |> Integer.parse |> elem(0)
        end
      end
    end
  end
end
