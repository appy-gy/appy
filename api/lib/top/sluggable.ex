defmodule Top.Sluggable do
  import Ecto.Changeset, only: [fetch_field: 2, get_field: 2, put_change: 3]

  def update_slug(changeset, field) do
    id = get_field changeset, :id
    slug = get_field changeset, :slug
    case fetch_field(changeset, field) do
      {:changes, new_value} when (is_nil(slug) or id == slug) and new_value != "" ->
        put_change changeset, :slug, Slugger.slugify_downcase(new_value)
      _ -> changeset
    end
  end
end
