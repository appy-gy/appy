defmodule Top.CounterCache do
  alias Top.Repo

  defmacro counter_cache(assoc, field) do
    method_name = :"update_#{field}_cache"

    quote do
      after_insert unquote(method_name), [1]
      after_delete unquote(method_name), [-1]

      def unquote(method_name)(changeset, by) do
        %{related: assoc_model, owner_key: assoc_key} = __MODULE__.__schema__(:association, unquote(assoc))
        record = Repo.get! assoc_model, get_field(changeset, assoc_key)
        record = assoc_model.changeset record, %{unquote(field) => record.unquote(field) + by}
        Repo.update! record
        changeset
      end
    end
  end
end
