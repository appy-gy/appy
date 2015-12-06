defmodule Top.Private.Rating.TagController do
  use Top.Web, :controller

  alias Top.Tag
  alias Top.Rating
  alias Top.RatingsTag
  alias Top.Private.TagView
  alias Top.RatingPolicy

  plug :fetch_current_user

  def create(conn, %{"rating_id" => rating_id, "name" => name}) do
    rating = Repo.find! Rating, rating_id

    if RatingPolicy.edit?(conn.assigns[:current_user], rating) do
      tag = get_tag name
      Repo.insert! RatingsTag.changeset(%RatingsTag{}, %{rating_id: rating.id, tag_id: tag.id})
      render conn, TagView, "show.json", tag: tag
    else
      send_error conn
    end
  end

  def delete(conn, %{"rating_id" => rating_id, "name" => name}) do
    rating = Repo.find! Rating, rating_id

    if RatingPolicy.edit?(conn.assigns[:current_user], rating) do
      tag = Repo.get_by! Tag, name: name
      ratings_tag = Repo.get_by! RatingsTag, rating_id: rating.id, tag_id: tag.id
      Repo.delete! ratings_tag
      render conn, TagView, "show.json", tag: tag
    else
      send_error conn
    end
  end

  defp get_tag(name) do
    case Repo.get_by Tag, name: name do
      nil -> Repo.insert! Tag.changeset(%Tag{}, %{name: name})
      tag -> tag
    end
  end
end
