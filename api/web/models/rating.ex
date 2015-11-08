defmodule Top.Rating do
  use Top.Web, :model

  import EctoEnum
  defenum StatusEnum, draft: 0, published: 1
  defenum MainPagePositionEnum, top: 0, left: 1, right: 2

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "ratings" do
    field :title, :string
    field :description, :string
    field :source, :string
    field :status, StatusEnum
    field :main_page_position, MainPagePositionEnum
    field :image, :string
    field :comments_count, :integer, default: 0
    field :likes_count, :integer, default: 0
    field :slug, :string
    field :published_at, Ecto.DateTime
    field :deleted_at, Ecto.DateTime
    field :words, {:array, :string}
    field :recommendations, {:array, Ecto.UUID}
    timestamps inserted_at: :created_at

    belongs_to :user, Top.User
    belongs_to :section, Top.Section
    has_many :items, Top.RatingItem, on_delete: :fetch_and_delete
    has_many :ratings_tags, Top.RatingsTag, on_delete: :fetch_and_delete
    has_many :tags, through: [:ratings_tags, :tag]
    has_many :comments, Top.Comment, on_delete: :delete_all
    has_many :likes, Top.Like, on_delete: :delete_all
  end

  @required_fields ~W(status comments_count likes_count words recommendations
    user_id)
  @optional_fields ~W(title description source main_page_position image slug
    published_at deleted_at section_id)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:section_id)
    |> unique_constraint(:slug)
    |> unique_constraint(:main_page_position)
  end
end
