defmodule Top.User do
  use Top.Web, :model

  import EctoEnum
  defenum RoleEnum, member: 0, admin: 1

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "users" do
    field :name, :string
    field :email, :string
    field :role, RoleEnum, default: :member
    field :crypted_password, :string
    field :salt, :string
    field :remember_me_token, :string
    field :remember_me_token_expires_at, Ecto.DateTime
    field :reset_password_token, :string
    field :reset_password_token_expires_at, Ecto.DateTime
    field :reset_password_email_sent_at, Ecto.DateTime
    field :avatar, :string
    field :background, :string
    field :slug, Top.Slug
    timestamps inserted_at: :created_at

    has_many :ratings, Top.Rating, on_delete: :fetch_and_delete
    has_many :comments, Top.Comment, on_delete: :fetch_and_delete
    has_many :likes, Top.Like, on_delete: :fetch_and_delete
    has_many :votes, Top.Vote, on_delete: :fetch_and_delete
  end

  import Top.ImageUploader
  image :avatar
  image :background

  before_update Top.Sluggable, :update_slug, [:name]

  @required_fields ~W(role slug)
  @optional_fields ~W(name email crypted_password salt remember_me_token
    remember_me_token_expires_at reset_password_token
    reset_password_token_expires_at reset_password_email_sent_at
    avatar background)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
    |> unique_constraint(:slug)
  end
end
