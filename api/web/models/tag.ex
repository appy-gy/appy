defmodule Top.Tag do
  use Top.Web, :model

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "tags" do
    field :name, :string
    field :ratings_count, :integer, default: 0
    field :slug, Top.Slug
    timestamps inserted_at: :created_at

    has_many :ratings_tags, Top.RatingsTag, on_delete: :fetch_and_delete
    has_many :ratings, through: [:ratings_tags, :rating]
  end

  @required_fields ~W(name ratings_count slug)
  @optional_fields ~W()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:slug)
  end
end
