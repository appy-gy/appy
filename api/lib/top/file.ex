defmodule Top.File do
  @moduledoc """
  Allows to store `Plug.Upload` structs in some model field for future
  processing
  """

  @behaviour Ecto.Type

  def type, do: :string

  def cast(term) when is_binary(term) or is_map(term) do
    {:ok, term}
  end

  def cast(_), do: :error

  def load(term) do
    {:ok, term}
  end

  def dump(string) when is_binary(string) do
    {:ok, string}
  end

  def dump(_), do: :error
end
