defmodule Top.Private.Rating.RatingItemController do
  use Top.Web, :controller
  import Ecto.Model, only: [assoc: 2]

  alias Top.Rating
  alias Top.RatingItem
  alias Top.RatingPolicy
  alias Top.Private.RatingItemView

  plug :fetch_current_user

  def index(conn, %{"rating_id" => rating_id}) do
    rating = Repo.find!(Rating, rating_id) |> Repo.preload(:items)
    votes = votes_for conn, rating.items
    render conn, RatingItemView, "index.json", items: rating.items, votes: votes
  end

  def create(conn, %{"rating_id" => rating_id, "rating_item" => rating_item_params}) do
    rating = Repo.find! Rating, rating_id
    if RatingPolicy.edit?(conn.assigns[:current_user], rating) do
      rating_item_params = filter_rating_item_params rating_item_params
      rating_item_params = Dict.put rating_item_params, "rating_id", rating.id
      shift_items! rating, rating_item_params
      changeset = RatingItem.changeset %RatingItem{}, rating_item_params
      case Repo.insert(changeset) do
        {:ok, item} -> render conn, RatingItemView, "show.json", item: item
        _ -> send_error conn
      end
    else
      send_error conn
    end
  end

  def update(conn, %{"rating_id" => rating_id, "id" => id, "rating_item" => rating_item_params}) do
    rating = Repo.find! Rating, rating_id
    if RatingPolicy.edit?(conn.assigns[:current_user], rating) do
      rating_item_params = filter_rating_item_params rating_item_params
      item = Repo.get! RatingItem, id
      changeset = RatingItem.changeset item, rating_item_params
      case Repo.update(changeset) do
        {:ok, item} -> render conn, RatingItemView, "show.json", item: item
        _ -> send_error conn
      end
    else
      send_error conn
    end
  end

  def delete(conn, %{"rating_id" => rating_id, "id" => id}) do
    rating = Repo.find! Rating, rating_id
    if RatingPolicy.edit?(conn.assigns[:current_user], rating) do
      item = Repo.get! RatingItem, id
      success = case Repo.delete(item) do
        {:ok, _} -> true
        _ -> false
      end
      json conn, %{success: success}
    else
      send_error conn
    end
  end

  def positions(conn, %{"rating_id" => rating_id, "positions" => positions}) do
    rating = Repo.find! Rating, rating_id
    if RatingPolicy.edit?(conn.assigns[:current_user], rating) and valid_positions?(rating, positions) do
      case Top.RatingItems.UpdatePositions.call(positions) do
        {:ok, _} ->
          query = from i in assoc(rating, :items), select: {i.id, i.position}
          positions = query |> Repo.all |> Enum.reduce(%{}, fn({id, position}, result) -> Dict.put(result, id, position) end)
          json conn, %{positions: positions}
        _ -> send_error conn
      end
    else
      send_error conn
    end
  end

  defp filter_rating_item_params(params) do
    Dict.take params, ~W{title description position image remove_image video_url}
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

  defp shift_items!(rating, params) do
    {position, ""} = params |> Dict.get("position") |> Integer.parse
    query = from i in assoc(rating, :items), where: i.position >= ^position
    positions = query |> Repo.all |> Enum.reduce(%{}, &(Dict.put &2, &1.id, &1.position + 1))
    Top.RatingItems.UpdatePositions.call positions
  end

  defp valid_positions?(rating, positions) do
    ids = Dict.keys positions
    query = from i in RatingItem, where: i.id in ^ids, select: i.rating_id
    query |> Repo.all |> Enum.all?(&(&1 == rating.id))
  end
end
