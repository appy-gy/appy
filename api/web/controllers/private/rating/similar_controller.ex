defmodule Top.Private.Rating.SimilarController do
  use Top.Web, :controller

  alias Top.Rating
  alias Top.Private.RatingView

  def index(conn, %{"rating_id" => id}) do
    rating = Repo.find! Rating, id
    query = from r in Rating, where: r.id in ^rating.recommendations, preload: [:user, :section, :tags]
    ratings = Repo.all query
    render conn, RatingView, "index.json", ratings: ratings
  end
end
