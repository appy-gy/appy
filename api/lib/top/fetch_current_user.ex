defmodule Top.FetchCurrentUser do
  import Plug.Conn, only: [assign: 3, fetch_cookies: 1]

  def fetch_current_user(conn) do
    conn
    |> fetch_cookies
    |> Map.get(:cookies)
    |> Dict.get("remember_me_token")
    |> query_user
    |> assign_user_info(conn)
  end

  defp query_user(token) when is_binary(token) do
    bare_token = token
    |> URI.decode
    |> String.split("--")
    |> List.first
    |> :base64.decode_to_string
    |> List.to_string
    |> String.strip(?")

    Top.Repo.get_by Top.User, remember_me_token: bare_token
  end

  defp query_user(_), do: nil

  defp assign_user_info(user, conn) do
    conn
    |> assign(:current_user, user)
    |> assign(:logged_in?, not is_nil(user))
  end
end
