defmodule Top.Private.MainPageRatingController do
  use Top.Web, :controller

  alias Top.Rating
  alias Top.Private.RatingView

  def index(conn, _params) do
    ratings = Rating.on_main_page |> Repo.all |> Repo.preload([:user, :section, :tags])
    render conn, RatingView, "main_page.json", ratings: ratings
  end
end
