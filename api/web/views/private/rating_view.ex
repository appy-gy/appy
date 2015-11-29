defmodule Top.Private.RatingView do
  use Top.Web, :view

  alias Top.Rating

  def render("main_page.json", %{ratings: ratings}) do
    positions = Top.Rating.MainPagePositionEnum.__enum_map__
      |> Dict.keys
      |> Enum.reduce %{}, fn position, result ->
        case Enum.find ratings, &(&1.main_page_position == position) do
          nil -> result
          rating -> Dict.put result, position, render_one(rating, __MODULE__, "rating.json")
        end
      end
    %{ratings: positions}
  end

  def render("index.json", %{ratings: ratings, pages_count: pages_count}) do
    Dict.put render("index.json", ratings: ratings), :meta, %{pages_count: pages_count}
  end

  def render("index.json", %{ratings: ratings}) do
    %{ratings: render_many(ratings, __MODULE__, "rating.json")}
  end

  def render("show.json", %{rating: rating, like: like}) do
    rating = render_one rating, __MODULE__, "rating.json"
    like = render_one like, Top.Private.LikeView, "like.json"
    %{rating: Dict.put(rating, :like, like)}
  end

  def render("rating.json", %{rating: rating}) do
    %{id: rating.id,
      title: rating.title,
      description: rating.description,
      source: rating.source,
      published_at: rating.published_at,
      created_at: rating.created_at,
      status: rating.status,
      main_page_position: rating.main_page_position,
      slug: rating.slug,
      image: Rating.image_url(rating),
      comments_count: rating.comments_count,
      likes_count: rating.likes_count,
      views_count: Rating.views_count(rating),
      user: render_one(rating.user, Top.Private.UserView, "user.json"),
      section: render_one(rating.section, Top.Private.SectionView, "section.json"),
      tags: render_many(rating.tags, Top.Private.TagView, "tag.json")}
  end

  def render("rating_for_comment.json", %{rating: rating}) do
    %{id: rating.id,
      title: rating.title,
      status: rating.status,
      slug: rating.slug,
      section: render_one(rating.section, Top.Private.SectionView, "section.json")}
  end
end
