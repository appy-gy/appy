defmodule Top.RatingItem do
  use Top.Web, :model

  import Top.ImageUploader

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "rating_items" do
    field :title, :string
    field :description, :string
    field :position, :integer
    field :mark, :integer, default: 0
    field :image, :string
    field :image_width, :integer
    field :image_height, :integer
    field :video, :map, default: %{}
    timestamps inserted_at: :created_at

    belongs_to :rating, Top.Rating
    has_many :votes, Top.Vote
  end

  image :image

  @required_fields ~W(rating_id position mark video)
  @optional_fields ~W(title description image image_width image_height)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:rating_id)
  end
end
