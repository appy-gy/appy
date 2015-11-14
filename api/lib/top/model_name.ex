defmodule Top.ModelName do
  def model_name(module) do
    module |> Mix.Utils.underscore |> String.split("/") |> List.last |> String.to_atom
  end

  defmacro __using__(_) do
    quote do
      def model_name do
        unquote(__MODULE__).model_name(__MODULE__)
      end
    end
  end
end
