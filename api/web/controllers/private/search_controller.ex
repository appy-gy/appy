defmodule Top.Private.SearchController do
  use Top.Web, :controller

  alias Top.GlobalIndex
  alias Top.Private.SearchResultView

  def global(conn, %{"query" => query}) do
    results = GlobalIndex.query query
    render conn, SearchResultView, "index.json", results: results
  end
end
