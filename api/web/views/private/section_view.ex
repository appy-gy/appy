defmodule Top.Private.SectionView do
  use Top.Web, :view

  def render("index.json", %{sections: sections}) do
    %{sections: render_many(sections, __MODULE__, "section.json")}
  end

  def render("show.json", %{section: section}) do
    %{section: render_one(section, __MODULE__, "section.json")}
  end

  def render("section.json", %{section: section}) do
    %{id: section.id,
      name: section.name,
      color: section.color,
      inverted_color: section.inverted_color,
      slug: section.slug,
      meta_title: section.meta_title,
      meta_description: section.meta_description,
      meta_keywords: section.meta_keywords}
  end
end
