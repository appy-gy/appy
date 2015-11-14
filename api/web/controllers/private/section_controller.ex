defmodule Top.Private.SectionController do
  use Top.Web, :controller

  alias Top.Section

  def index(conn, _params) do
    sections = Repo.all Section
    render conn, "index.json", sections: sections
  end

  def show(conn, %{"id" => id}) do
    section = Repo.find! Section, id
    render conn, "show.json", section: section
  end
end
