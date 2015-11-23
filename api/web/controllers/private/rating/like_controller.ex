defmodule Top.Private.Rating.LikeController do
  use Top.Web, :controller

  alias Top.Like
  alias Top.Rating
  alias Top.Private.LikeView

  plug :fetch_current_user

  def create(conn, %{"rating_id" => rating_id}) do
    rating = Repo.find Rating, rating_id
    params = %{user_id: conn.assigns[:current_user].id, rating_id: rating.id}
    changeset = Like.changeset(%Like{}, params)

    case Repo.insert(changeset) do
      {:ok, like} ->
        render conn, LikeView, "show.json", like: like, likes_count: rating.likes_count + 1
      {:error, _} ->
        conn |> put_status(400) |> json(%{})
    end
  end

  def delete(conn, %{"rating_id" => rating_id}) do
    rating = Repo.find Rating, rating_id
    query = from l in Like, where: l.rating_id == ^rating.id and l.user_id == ^conn.assigns[:current_user].id, limit: 1
    like = Repo.one query

    case Repo.delete(like) do
      {:ok, _} ->
        render conn, LikeView, "delete.json", success: true, likes_count: rating.likes_count - 1
      {:error, _} ->
        conn |> put_status(400) |> render(LikeView, "delete.json", success: false, likes_count: rating.likes_count)
    end
  end
end
