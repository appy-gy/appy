defmodule Top.Private.SectionView do
  use Top.Web, :view

  def render("index.json", %{sections: sections}) do
    %{sections: render_many(sections, Top.Private.SectionView, "section.json")}
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
