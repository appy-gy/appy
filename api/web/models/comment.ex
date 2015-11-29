defmodule Top.Comment do
  use Top.Web, :model

  import Top.CounterCache

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "comments" do
    field :body, :string
    timestamps inserted_at: :created_at

    belongs_to :user, Top.User
    belongs_to :rating, Top.Rating
    belongs_to :parent, __MODULE__
    has_many :children, __MODULE__, foreign_key: :parent_id, on_delete: :fetch_and_delete
  end

  counter_cache :rating, :comments_count

  @required_fields ~W(body user_id rating_id)
  @optional_fields ~W(parent_id)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:rating_id)
    |> foreign_key_constraint(:parent_id)
  end
end
