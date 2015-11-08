defmodule Top.Page do
  use Top.Web, :model

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "pages" do
    field :title, :string
    field :body, :string
    field :slug, :string
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
