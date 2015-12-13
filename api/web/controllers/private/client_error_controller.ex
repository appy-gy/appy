defmodule Top.Private.ClientErrorController do
  use Top.Web, :controller

  alias Top.ClientError

  @permited_keys ~W{user_id url user_agent message filename lineno colno stack}

  def create(conn, %{"info" => info}) do
    info = Dict.take info, @permited_keys
    changeset = ClientError.changeset %ClientError{}, %{info: info}
    success = case Repo.insert(changeset) do
      {:ok, _} -> true
      _ -> false
    end
    json conn, %{success: success}
  end
end
