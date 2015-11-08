defmodule Top.Section do
  use Top.Web, :model

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "sections" do
    field :name, :string
    field :color, :string
    field :inverted_color, :string
    field :position, :integer, default: 0
    field :slug, Top.Slug
    field :meta_title, :string
    field :meta_description, :string
    field :meta_keywords, :string
    timestamps inserted_at: :created_at

    has_many :ratings, Top.Rating
  end

  @required_fields ~W(name color inverted_color position slug meta_title
    meta_description meta_keywords)
  @optional_fields ~W()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:slug)
  end
end
