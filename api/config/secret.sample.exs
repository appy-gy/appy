use Mix.Config

config :top, Top.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "top",
  password: "",
  database: "top",
  hostname: "localhost",
  pool_size: 10

config :top, Top.Index,
  prefix: "top"
