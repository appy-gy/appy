defmodule Top.Private.VoteView do
  use Top.Web, :view

  def render("show.json", %{vote: vote, mark: mark}) do
    %{vote: render_one(vote, __MODULE__, "vote.json"), meta: %{mark: mark}}
  end

  def render("vote.json", %{vote: vote}) when is_map vote do
    %{id: vote.id,
      kind: vote.kind}
  end
end
