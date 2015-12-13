defmodule Top.Vote do
  use Top.Web, :model

  alias Top.Repo

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

  after_insert :update_rating_item_mark
  after_update :update_rating_item_mark
  after_delete :update_rating_item_mark

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:rating_item_id)
  end

  def update_rating_item_mark(changeset) do
    rating_item = assoc(changeset.model, :rating_item) |> Repo.one
    votes = assoc(rating_item, :votes)
    up_count = from v in votes, where: v.kind == "up", select: count(v.id)
    down_count = from v in votes, where: v.kind == "down", select: count(v.id)
    item_changeset = Top.RatingItem.changeset rating_item, %{mark: Repo.one(up_count) - Repo.one(down_count)}
    Repo.update item_changeset
    changeset
  end
end
