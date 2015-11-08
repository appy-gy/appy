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

  @required_fields ~W(rating_id tag_id)
  @optional_fields ~W()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:rating_id)
    |> foreign_key_constraint(:tag_id)
  end

  after_insert :update_ratings_counter, [1]
  after_delete :update_ratings_counter, [-1]

  def update_ratings_counter(changeset, by) do
    tag = Repo.get! Tag, get_field(changeset, :tag_id)
    tag = Tag.changeset tag, %{ratings_count: tag.ratings_count + by}
    Repo.update! tag
    changeset
  end
end
