defmodule Top.Private.RatingItem.VoteController do
  use Top.Web, :controller

  alias Top.Vote
  alias Top.Private.VoteView

  plug :fetch_current_user

  def create(conn, %{"rating_item_id" => rating_item_id, "vote" => vote_params}) do
    vote_params = vote_params
    |> Dict.take(~w{kind})
    |> Dict.merge(%{"rating_item_id" => rating_item_id, "user_id" => conn.assigns[:current_user].id})
    vote = create_or_update_vote vote_params
    mark = mark_of rating_item_id
    render conn, VoteView, "show.json", vote: vote, mark: mark
  end

  defp create_or_update_vote(params) do
    case Repo.get_by Vote, rating_item_id: params["rating_item_id"], user_id: params["user_id"] do
      nil -> create_vote params
      vote -> update_vote vote, params
    end
  end

  defp create_vote(params) do
    changeset = Vote.changeset %Vote{}, params
    Repo.insert! changeset
  end

  defp update_vote(vote, params) do
    changeset = Vote.changeset vote, params
    Repo.update! changeset
  end

  defp mark_of(rating_item_id) do
    rating_item = Repo.get! Top.RatingItem, rating_item_id
    rating_item.mark
  end
end
