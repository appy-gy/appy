defmodule Top.Private.MainPageRatingController do
  use Top.Web, :controller

  alias Top.Rating
  alias Top.Private.RatingView

  def index(conn, _params) do
    query = from r in Rating.on_main_page, preload: [:user, :section, :tags]
    ratings = Repo.all query
    render conn, RatingView, "main_page.json", ratings: ratings
  end
end
