defmodule Top.Private.PageView do
  use Top.Web, :view

  def render("index.json", %{pages: pages}) do
    %{pages: render_many(pages, __MODULE__, "page.json")}
  end

  def render("show.json", %{page: page}) do
    %{page: render_one(page, __MODULE__, "page.json")}
  end

  def render("page.json", %{page: page}) do
    %{id: page.id,
      title: page.title,
      body: page.body,
      slug: page.slug}
  end
end
