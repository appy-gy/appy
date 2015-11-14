defmodule Top.Private.LikeView do
  use Top.Web, :view

  def render("like.json", %{like: like}) do
    %{id: like.id,
      rating_id: like.rating_id}
  end
end
