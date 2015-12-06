defmodule Top.Private.Rating.CommentController do
  use Top.Web, :controller

  alias Top.Comment
  alias Top.Rating
  alias Top.Private.CommentView
  alias Top.RatingPolicy

  plug :fetch_current_user

  def index(conn, %{"rating_id" => rating_id}) do
    rating = Repo.find!(Rating, rating_id) |> Repo.preload(comments: [:user, rating: [:section]])
    render conn, CommentView, "index.json", comments: rating.comments
  end

  def create(conn, %{"rating_id" => rating_id, "comment" => comment_params}) do
    rating = Repo.find! Rating, rating_id

    if RatingPolicy.comment?(conn.assigns[:current_user], rating) do
      comment_params = comment_params
        |> Dict.take(~W{body parent_id})
        |> Dict.merge(%{"rating_id" => rating_id, "user_id" => conn.assigns[:current_user].id})
      changeset = Comment.changeset %Comment{}, comment_params

      case Repo.insert(changeset) do
        {:ok, comment} ->
          comment = Repo.preload comment, [:user, rating: [:section]]
          render conn, CommentView, "show.json", comment: comment
        {:error, _} -> send_error conn
      end
    else
      send_error conn
    end
  end
end
