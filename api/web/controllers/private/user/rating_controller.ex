defmodule Top.Private.User.RatingController do
  use Top.Web, :controller

  alias Top.Rating
  alias Top.Private.RatingView

  @page_size 12

  plug :fetch_current_user

  def index(conn, params) do
    user = Repo.find! Top.User, params["user_id"]
    query = Rating.of conn.assigns[:current_user], user
    query = from r in query, order_by: [desc: r.updated_at], preload: [:user, :section, :tags]
    page = Repo.paginate query, page: params["page"], page_size: @page_size
    render conn, RatingView, "index.json", ratings: page.entries, pages_count: page.total_pages
  end
end
