use Mix.Config

# Configure your database
config :top, Top.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "top",
  password: "",
  database: "top",
  hostname: "localhost",
  pool_size: 10
