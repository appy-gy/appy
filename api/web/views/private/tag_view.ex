defmodule Top.Private.TagView do
  use Top.Web, :view

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id,
      name: tag.name,
      ratings_count: tag.ratings_count,
      slug: tag.slug}
  end
end
