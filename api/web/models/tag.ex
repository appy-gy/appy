defmodule Top.Tag do
  use Top.Web, :model

  alias Top.Repo

  import Top.Sluggable
  import Top.ModelIndex

  schema "tags" do
    field :name, :string
    field :ratings_count, :integer, default: 0
    field :slug, Top.Slug
    timestamps inserted_at: :created_at

    has_many :ratings_tags, Top.RatingsTag, on_delete: :fetch_and_delete
    has_many :ratings, through: [:ratings_tags, :rating]
  end

  slug :name

  index Top.TagIndex

  after_update :delete_if_unused

  @required_fields ~W(name ratings_count)
  @optional_fields ~W(slug)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:slug)
    |> downcase_name
  end

  defp downcase_name(changeset) do
    case fetch_change(changeset, :name) do
      {:ok, name} -> put_change changeset, :name, String.downcase(name)
      _ -> changeset
    end
  end

  defp delete_if_unused(changeset) do
    case fetch_change(changeset, :ratings_count) do
      {:ok, count} when count == 0 ->
        Repo.delete changeset.model
        changeset
      _ -> changeset
    end
  end
end
