defmodule Top.Page do
  use Top.Web, :model

  schema "pages" do
    field :title, :string
    field :body, :string
    field :slug, Top.Slug
    timestamps inserted_at: :created_at
  end

  @required_fields ~W(title body slug)
  @optional_fields ~W()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:slug)
  end
end
