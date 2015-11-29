defmodule Top.ModelIndex do
  defmacro index(index) do
    quote do
      after_insert unquote(__MODULE__), :reindex, [unquote(index)]
      after_update unquote(__MODULE__), :reindex, [unquote(index)]
    end
  end

  def reindex(changeset, index) do
    Task.start fn -> index.update changeset.model end
    changeset
  end
end
