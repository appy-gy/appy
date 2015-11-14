defmodule Top.Private.Rating.CommentController do
  use Top.Web, :controller

  alias Top.Rating
  alias Top.Private.CommentView

  plug :fetch_current_user

  def index(conn, %{"rating_id" => rating_id}) do
    rating = Repo.find!(Rating, rating_id) |> Repo.preload(comments: [:user, rating: [:section]])
    render conn, CommentView, "index.json", comments: rating.comments
  end
end
