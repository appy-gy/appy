defmodule Top.Private.Page.FooterController do
  use Top.Web, :controller

  alias Top.Page
  alias Top.Private.PageView

  @pages ~w{about advertising}

  def index(conn, _params) do
    query = from p in Page, where: p.slug in @pages
    pages = Repo.all query
    render conn, PageView, "index.json", pages: pages
  end
end
