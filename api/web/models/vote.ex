defmodule Top.Vote do
  use Top.Web, :model

  import EctoEnum
  defenum KindEnum, up: 0, down: 1

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "votes" do
    field :kind, KindEnum
    timestamps inserted_at: :created_at

    belongs_to :user, Top.User
    belongs_to :rating_item, Top.RatingItem
  end

  @required_fields ~W(kind user_id rating_item_id)
  @optional_fields ~W()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:rating_item_id)
  end
end
