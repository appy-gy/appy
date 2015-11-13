defmodule Top.Endpoint do
  use Phoenix.Endpoint, otp_app: :top

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: PlugRailsCookieSessionStore,
    key: Application.get_env(:top, Top.Session)[:key],
    domain: "appy.gy",
    secure: true,
    signing_salt: Application.get_env(:top, Top.Session)[:signing_salt],
    encrypt: true,
    encryption_salt: Application.get_env(:top, Top.Session)[:encryption_salt],
    key_iterations: 1000,
    key_length: 64,
    key_digest: :sha,
    serializer: Poison

  plug Top.Router
end
