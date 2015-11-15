defmodule Top.Private.CommentView do
  use Top.Web, :view

  def render("index.json", %{comments: comments, pages_count: pages_count}) do
    Dict.put render("index.json", comments: comments), :meta, %{pages_count: pages_count}
  end

  def render("index.json", %{comments: comments}) do
    %{comments: render_many(comments, __MODULE__, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      body: comment.body,
      parent_id: comment.parent_id,
      rating_id: comment.rating_id,
      created_at: comment.created_at,
      user: render_one(comment.user, Top.Private.UserView, "user_for_comment.json"),
      rating: render_one(comment.rating, Top.Private.RatingView, "rating_for_comment.json")}
  end
end
