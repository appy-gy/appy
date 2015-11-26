defmodule Top.Private.VoteView do
  use Top.Web, :view

  def render("vote.json", %{vote: vote}) when is_map vote do
    %{id: vote.id,
      kind: vote.kind}
  end
end
