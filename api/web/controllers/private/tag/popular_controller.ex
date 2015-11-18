defmodule Top.Private.Tag.PopularController do
  use Top.Web, :controller

  alias Top.Tag
  alias Top.Private.TagView

  @limit 10

  def index(conn, _params) do
    query = from t in Tag, order_by: [desc: :ratings_count], limit: @limit
    tags = Repo.all query
    render conn, TagView, "index.json", tags: tags
  end
end
