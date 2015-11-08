defmodule Top.ImageUploader do
  import Top.ModelName

  defmacro image(field) do
    quote do
      def unquote(:"#{field}_url")(record) do
        id = String.replace record.id, "-", "/"
        "/system/#{model_name(__MODULE__)}/#{unquote(field)}/#{id}/#{record.unquote(field)}"
      end
    end
  end
end
