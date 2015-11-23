defmodule Top.Private.Tag.RatingController do
  use Top.Web, :controller
  import Ecto.Model, only: [assoc: 2]

  alias Top.Rating
  alias Top.Private.RatingView

  @page_size 15

  def index(conn, params) do
    tag = Repo.find! Top.Tag, params["tag_id"]
    query = from r in assoc(tag, :ratings), order_by: [desc: r.published_at], preload: [:user, :section, :tags]
    query = query |> Rating.published |> Rating.not_deleted
    page = Repo.paginate query, page: params["page"], page_size: @page_size
    render conn, RatingView, "index.json", ratings: page.entries, pages_count: page.total_pages
  end
end
