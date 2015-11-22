defmodule Top.FetchCurrentUser do
  import Plug.Conn, only: [assign: 3, fetch_cookies: 1]

  alias Top.Repo
  alias Top.User

  @iterations 1000
  @key_size 64
  @salt "encrypted cookie"
  @signed_salt "signed encrypted cookie"
  @session_key "_top_session"
  @secret_key Application.get_env(:top, Top.FetchCurrentUser)[:secret_key]

  def fetch_current_user(conn, _) do
    conn
    |> fetch_cookies
    |> Map.get(:cookies)
    |> fetch_from_cookies
    |> assign_user_info(conn)
  end

  defp fetch_from_cookies(cookies) do
    fetch_from_session(cookies) || fetch_from_remember_me(cookies)
  end

  defp assign_user_info(user, conn) do
    conn
    |> assign(:current_user, user)
    |> assign(:logged_in?, not is_nil(user))
  end

  defp fetch_from_session(%{@session_key => cookie}) do
    case decrypt(cookie) do
      {:ok, session} ->
        session |> Poison.decode! |> Dict.get("user_id") |> query_user_by_id
      :error -> nil
    end
  end
  defp fetch_from_session(_cookies), do: nil

  defp fetch_from_remember_me(%{"remember_me_token" => token}) do
    token
    |> URI.decode
    |> String.split("--")
    |> List.first
    |> Base.decode64!
    |> String.strip(?")
    |> query_user_by_token
  end
  defp fetch_from_remember_me(_cookies), do: nil

  defp query_user_by_id(id) when is_nil(id), do: nil
  defp query_user_by_id(id), do: Repo.get(User, id)

  defp query_user_by_token(token) when is_nil(token), do: nil
  defp query_user_by_token(token), do: Repo.get_by(User, remember_me_token: token)

  defp decrypt(cookie) do
    secret = generate @salt
    sign_secret = generate @signed_salt

    case cookie |> URI.decode |> verify(sign_secret) do
      {:ok, message} -> {:ok, decrypt_message(message, secret)}
      :error -> :error
    end
  end

  defp generate(salt) do
    Plug.Crypto.KeyGenerator.generate @secret_key, salt, iterations: @iterations, length: @key_size, digest: :sha, cache: Plug.Keys
  end

  defp verify(cookie, secret) do
    [content, digest] = String.split cookie, "--"
    if Plug.Crypto.secure_compare(digest(content, secret), digest) do
      {:ok, Base.decode64!(content)}
    else
      :error
    end
  end

  defp decrypt_message(message, secret) do
    [encrypted, iv] = message |> String.split("--") |> Enum.map(&Base.decode64!/1)
    :crypto.block_decrypt(:aes_cbc256, :binary.part(secret, 0, 32), iv, encrypted)
    |> unpad_message
  end

  defp digest(content, secret) do
    :crypto.hmac(:sha, secret, content) |> Base.encode16(case: :lower)
  end

  defp unpad_message(message) do
    padding_size = :binary.last message
    message_size = byte_size message
    binary_part message, 0, message_size - padding_size
  end
end
