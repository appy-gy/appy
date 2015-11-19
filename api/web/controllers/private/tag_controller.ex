defmodule Top.Private.TagController do
  use Top.Web, :controller

  alias Top.Tag

  def index(conn, %{"query" => query}) do
    tags = Top.TagIndex.query query
    render conn, "index.json", tags: tags
  end

  def show(conn, %{"id" => id}) do
    tag = Repo.find! Tag, id
    render conn, "show.json", tag: tag
  end
end
