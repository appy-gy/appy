defmodule Top.Private.RatingController do
  use Top.Web, :controller

  alias Top.Rating

  plug :fetch_current_user

  def show(conn, %{"id" => slug}) do
    rating = Repo.get_by!(Rating, slug: slug) |> Repo.preload([:user, :section, :tags])
    like = like_for conn, rating
    render conn, "show.json", rating: rating, like: like
  end

  defp like_for(conn, rating) do
    case conn.assigns[:current_user] do
      nil -> nil
      user -> Repo.get_by Top.Like, rating_id: rating.id, user_id: user.id
    end
  end
end
