defmodule Top.Like do
  use Top.Web, :model

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "likes" do
    timestamps inserted_at: :created_at

    belongs_to :user, Top.User
    belongs_to :rating, Top.Rating
  end

  import Top.CounterCache
  counter_cache :rating, :likes_count

  @required_fields ~W(user_id rating_id)
  @optional_fields ~W()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:rating_id)
    |> unique_constraint(:rating_id, name: :index_likes_on_rating_id_and_user_id)
  end
end
