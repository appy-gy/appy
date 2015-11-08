defmodule Top.RatingsTag do
  use Top.Web, :model

  alias Top.Repo
  alias Top.Tag

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "ratings_tags" do
    belongs_to :rating, Top.Rating
    belongs_to :tag, Tag
  end

  import Top.CounterCache
  counter_cache :tag, :ratings_count

  @required_fields ~W(rating_id tag_id)
  @optional_fields ~W()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:rating_id)
    |> foreign_key_constraint(:tag_id)
  end
end
