defmodule Top.Sluggable do
  import Ecto.Changeset, only: [fetch_change: 2, get_field: 2, put_change: 3]

  def update_slug(changeset, field) do
    id = get_field changeset, :id
    slug = get_field changeset, :slug
    case fetch_change(changeset, field) do
      {:ok, value} when (is_nil(slug) or id == slug) and value != "" ->
        put_change changeset, :slug, Slugger.slugify_downcase(value)
      _ -> changeset
    end
  end
end
