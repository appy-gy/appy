defmodule Top.Private.SessionController do
  use Top.Web, :controller

  alias Top.Private.CurrentUserView

  plug :fetch_current_user when action in [:show]

  def show(conn, _params) do
    render conn, CurrentUserView, "show.json", user: conn.assigns[:current_user]
  end

  def check(conn, %{"cookies" => cookies}) do
    user = cookies |> Poison.decode! |> Top.FetchCurrentUser.fetch_user_from_cookies
    info = %{logged_in: not is_nil(user)}
    json conn, info
  end
end
