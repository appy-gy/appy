defmodule Top.Private.User.CommentController do
  use Top.Web, :controller
  import Ecto.Model, only: [assoc: 2]

  alias Top.Private.CommentView

  @page_size 15

  def index(conn, params) do
    user = Repo.find! Top.User, params["user_id"]
    query = from r in assoc(user, :comments), order_by: [desc: r.created_at], preload: [:user, rating: [:section]]
    page = Repo.paginate query, page: params["page"], page_size: @page_size
    render conn, CommentView, "index.json", comments: page.entries, pages_count: page.total_pages
  end
end
