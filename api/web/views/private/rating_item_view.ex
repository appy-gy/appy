defmodule Top.Private.RatingItemView do
  use Top.Web, :view

  alias Top.RatingItem

  def render("index.json", %{items: items, votes: votes}) do
    vote_for = fn item -> Enum.find votes, &(&1.rating_item_id == item.id) end
    %{rating_items: render_many(items, __MODULE__, "item.json", as: :item, vote_for: vote_for)}
  end

  def render("show.json", %{item: item}) do
    %{rating_item: render_one(item, __MODULE__, "item.json", as: :item)}
  end

  def render("item.json", %{item: item, vote: vote}) do
    %{id: item.id,
      title: item.title,
      description: item.description,
      created_at: item.created_at,
      position: item.position,
      mark: item.mark,
      image: RatingItem.image_url(item),
      video: item.video,
      image_width: item.image_width,
      image_height: item.image_height,
      vote: render_existing(Top.Private.VoteView, "vote.json", vote: vote)}
  end

  def render("item.json", %{item: item, vote_for: vote_for}) do
    render "item.json", %{item: item, vote: vote_for.(item)}
  end

  def render("item.json", %{item: item}) do
    render "item.json", %{item: item, vote: nil}
  end
end
