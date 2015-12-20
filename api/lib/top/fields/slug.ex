defmodule Top.Slug do
  @behaviour Ecto.Type

  def type, do: :string

  def cast(term) do
    {:ok, term}
  end

  def load(term) do
    {:ok, term}
  end

  def dump(string) when is_binary(string) do
    {:ok, Slugger.slugify_downcase(string)}
  end

  def dump(_), do: :error
end
