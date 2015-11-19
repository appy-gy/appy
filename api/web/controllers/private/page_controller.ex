defmodule Top.Private.PageController do
  use Top.Web, :controller

  alias Top.Page

  def show(conn, %{"id" => id}) do
    page = Repo.find!(Page, id)
    render conn, "show.json", page: page
  end
end
