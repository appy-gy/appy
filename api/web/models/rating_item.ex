defmodule Top.RatingItem do
  use Top.Web, :model

  import Top.ImageUploader

  schema "rating_items" do
    field :title, :string
    field :description, :string
    field :position, :integer
    field :mark, :integer, default: 0
    field :image, Top.File
    field :image_width, :integer
    field :image_height, :integer
    field :video, :map, default: %{}
    field :remove_image, :boolean, virtual: true
    field :video_url, :string, virtual: true
    timestamps inserted_at: :created_at

    belongs_to :rating, Top.Rating
    has_many :votes, Top.Vote
  end

  image :image, versions: [normal: {880, nil}], resize: :resize_to_limit

  @required_fields ~W(rating_id position mark video)
  @optional_fields ~W(title description image image_width image_height
    remove_image video_url)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:rating_id)
    |> remove_image
    |> set_image_size
    |> get_video_info
  end

  defp remove_image(changeset) do
    case fetch_change(changeset, :remove_image) do
      {:ok, value} when value in [true, "true"] ->
        changeset
        |> delete_change(:remove_image)
        |> put_change(:image, nil)
      _ -> changeset
    end
  end

  defp set_image_size(changeset) do
    case fetch_change(changeset, :image) do
      {:ok, %{path: path}} ->
        %{width: width, height: height} = Mogrify.open(path) |> Mogrify.verbose
        {width, ""} = Integer.parse width
        {height, ""} = Integer.parse height
        changeset |> put_change(:image_width, width) |> put_change(:image_height, height)
      _ -> changeset
    end
  end

  defp get_video_info(changeset) do
    case fetch_change(changeset, :video_url) do
      {:ok, url} ->
        video = case url do
          "" -> %{}
          _ -> Top.VideoInfo.load url
        end
        changeset
        |> delete_change(:video_url)
        |> put_change(:video, video)
      _ -> changeset
    end
  end
end
