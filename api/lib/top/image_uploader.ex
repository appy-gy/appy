defmodule Top.ImageUploader do
  defmacro image(field) do
    quote do
      def unquote(:"#{field}_url")(%{unquote(field) => nil}), do: nil
      def unquote(:"#{field}_url")(record) do
        id = String.replace record.id, "-", "/"
        "/system/#{model_name}/#{unquote(field)}/#{id}/#{record.unquote(field)}"
      end
    end
  end
end
