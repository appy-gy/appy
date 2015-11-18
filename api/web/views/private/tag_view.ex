defmodule Top.Private.TagView do
  use Top.Web, :view

  def render("index.json", %{tags: tags}) do
    %{tags: render_many(tags, __MODULE__, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{tag: render_one(tag, __MODULE__, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id,
      name: tag.name,
      ratings_count: tag.ratings_count,
      slug: tag.slug}
  end
end
