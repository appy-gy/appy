defmodule Top.ModelIndex do
  defmacro index(index) do
    quote do
      after_save unquote(__MODULE__), :reindex, [unquote(index)]
    end
  end

  def reindex(changeset, index) do
    Task.start fn -> index.update changeset.model end
    changeset
  end
end
