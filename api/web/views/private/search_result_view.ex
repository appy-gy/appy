defmodule Top.Private.SearchResultView do
  use Top.Web, :view

  def render("index.json", %{results: results}) do
    %{results: render_many(results, __MODULE__, "result.json", as: :result)}
  end

  def render("result.json", %{result: result}) do
    type = result.__struct__.model_name |> Atom.to_string |> Phoenix.Naming.underscore
    data = render_one result, __MODULE__, "#{type}.json", as: String.to_atom(type)
    Dict.put data, :type, type
  end

  def render("rating.json", %{rating: rating}) do
    %{id: rating.id,
      title: rating.title,
      description: rating.description,
      image: Top.Rating.image_url(rating),
      slug: rating.slug}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      avatar: Top.User.avatar_url(user),
      slug: user.slug}
  end
end
