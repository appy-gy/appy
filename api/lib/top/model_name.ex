defmodule Top.ModelName do
  def model_name(module) do
    module |> Atom.to_string |> String.split(".") |> List.last |> String.downcase
  end
end
