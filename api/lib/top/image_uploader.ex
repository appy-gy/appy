defmodule Top.ImageUploader do
  defmacro image(field) do
    quote do
      def unquote(:"#{field}_url")(record) do
        id = String.replace record.id, "-", "/"
        "/system/#{__MODULE__.model_name}/#{unquote(field)}/#{id}/#{record.unquote(field)}"
      end
    end
  end
end
