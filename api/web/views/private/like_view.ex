defmodule Top.Private.LikeView do
  use Top.Web, :view

  def render("show.json", %{like: nil, likes_count: likes_count}) do
    %{like: nil, meta: %{likes_count: likes_count}}
  end

  def render("show.json", %{like: like, likes_count: likes_count}) do
    data = %{like: render_one(like, __MODULE__, "like.json")}
    Dict.put data, :meta, %{likes_count: likes_count}
  end

  def render("delete.json", %{success: success, likes_count: likes_count}) do
    %{success: success, meta: %{likes_count: likes_count}}
  end

  def render("like.json", %{like: like}) do
    %{id: like.id,
      rating_id: like.rating_id}
  end
end
