defmodule Top.Private.UserController do
  use Top.Web, :controller
  import Ecto.Model, only: [assoc: 2]

  alias Top.User

  plug :fetch_current_user

  def show(conn, %{"id" => id}) do
    user = Repo.find! User, id
    render conn, "show.json", user: user, counts: counts_for(conn, user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.find! User, id
    user_params = Dict.take user_params, ~W{name avatar background}
    changeset = User.changeset user, user_params

    case Repo.update(changeset) do
      {:ok, user} ->
        render conn, "show.json", user: user, counts: counts_for(conn, user)
      {:error, _} -> send_error conn
    end
  end

  def change_password(conn, %{"user_id" => id, "old_password" => old_password, "new_password" => new_password}) do
    user = Repo.find! User, id
    if Top.Password.valid?(old_password, user.crypted_password, user.salt) do
      changeset = User.changeset user, %{password: new_password}
      case Repo.update(changeset) do
        {:ok, user} -> json conn, %{success: true}
        {:error, _} -> send_error conn
      end
    else
      send_error conn
    end
  end

  defp counts_for(conn, user) do
    ratings_count = ratings_count_for conn, user
    comments_count = comments_count_for user
    %{ratings: ratings_count, comments: comments_count}
  end

  defp ratings_count_for(conn, user) do
    query = from r in Top.Rating.of(conn.assigns[:current_user], user), select: count(r.id)
    Repo.one query
  end

  defp comments_count_for(user) do
    query = from c in assoc(user, :comments), select: count(c.id)
    Repo.one query
  end
end
