defmodule Top.SendError do
  import Plug.Conn, only: [put_status: 2]
  import Phoenix.Controller, only: [json: 2]

  def send_error(conn, error \\ "") do
    conn |> put_status(400) |> json(%{error: error})
  end
end
