defmodule Top.ModelName do
  @moduledoc """
  Adds `model_name` method to model module. Already used whe you
  `use Top.Web, :model`

  ## Example

      defmodule Top.RatingItem do
        use Top.Web, :model
      end

      Top.RatingItem.model_name # => :rating_item
  """

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
