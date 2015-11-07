defmodule Top.Private.HeaderSectionController do
  use Top.Web, :controller

  alias Top.Section
  alias Top.Private.SectionView

  def index(conn, _params) do
    query = from s in Section, order_by: s.position
    sections = Repo.all query
    render conn, SectionView, "index.json", sections: sections
  end
end
