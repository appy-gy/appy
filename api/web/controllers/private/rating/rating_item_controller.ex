defmodule Top.Private.Rating.RatingItemController do
  use Top.Web, :controller
  import Ecto.Model, only: [assoc: 2]

  alias Top.Rating
  alias Top.Private.RatingItemView

  plug :fetch_current_user

  def index(conn, %{"rating_id" => rating_id}) do
    rating = Repo.find!(Rating, rating_id) |> Repo.preload(:items)
    votes = votes_for conn, rating.items
    render conn, RatingItemView, "index.json", items: rating.items, votes: votes
  end

  defp votes_for(conn, items) do
    case conn.assigns[:current_user] do
      nil -> []
      user ->
        ids = Enum.map items, &(&1.id)
        query = from v in assoc(user, :votes), where: v.rating_item_id in ^ids
        Repo.all query
    end
  end
end
