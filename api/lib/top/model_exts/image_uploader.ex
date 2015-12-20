defmodule Top.ImageUploader do
  @moduledoc """
  Adds image `image` macro to the importing module. When this macro called it
  defines two methods. One for image processing on the record save to the
  database and second for url generation. Image field type should be `Top.File`

  ## Example

      defmodule Foo do
        import Top.ImageUploader

        schema "foos" do
          field :image, Top.File
        end

        image :image, versions: [normal: {100, 100}]
      end
  """

  import Ecto.Changeset, only: [fetch_change: 2, put_change: 3, delete_change: 2]

  def url_for(record, field) do
    public_dir_for(record, field) |> Path.join(Map.get(record, field))
  end

  def path_for(record, field) do
    ["../../../../public", public_dir_for(record, field)] |> Path.join |> Path.expand(__DIR__)
  end

  def process(changeset, field, opts) do
    case do_process(fetch_change(changeset, field), changeset, field, opts) do
      path when is_binary(path) -> put_change(changeset, field, path)
      nil -> changeset
      _ -> delete_change(changeset, field)
    end
  end

  defp do_process({:ok, %{path: path, filename: filename}}, changeset, field, opts) do
    record = changeset.model
    dest = path_for record, field
    Top.ImageProcessor.process path, dest, filename, opts
    filename
  end
  defp do_process(_, _, _, _), do: nil

  defp public_dir_for(record, field) do
    id = String.replace record.id, "-", "/"
    "/system/#{record.__struct__.model_name}/#{field}/#{id}"
  end

  defmacro image(field, opts \\ []) do
    quote do
      before_save :"process_#{unquote(field)}"

      def unquote(:"#{field}_url")(%{unquote(field) => nil}), do: nil
      def unquote(:"#{field}_url")(record) do
        unquote(__MODULE__).url_for(record, unquote(field))
      end

      def unquote(:"process_#{field}")(changeset) do
        unquote(__MODULE__).process(changeset, unquote(field), unquote(opts))
      end
    end
  end
end
