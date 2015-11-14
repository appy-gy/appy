defmodule Top.Private.RatingController do
  use Top.Web, :controller

  alias Top.Rating

  @page_size 18

  plug :fetch_current_user when action in [:show]

  def index(conn, params) do
    query = Rating.not_on_main_page |> Rating.published
    query = from r in query, order_by: [desc: r.published_at], preload: [:user, :section, :tags]
    page = Repo.paginate query, page: params["page"], page_size: @page_size
    render conn, "index.json", ratings: page.entries, pages_count: page.total_pages
  end

  def show(conn, %{"id" => id}) do
    rating = Repo.find!(Rating, id) |> Repo.preload([:user, :section, :tags])
    like = like_for conn, rating
    render conn, "show.json", rating: rating, like: like
  end

  defp like_for(conn, rating) do
    case conn.assigns[:current_user] do
      nil -> nil
      user -> Repo.get_by Top.Like, rating_id: rating.id, user_id: user.id
    end
  end
end
