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

config :top, Top.VideoInfo,
  vimeo_api_key: ""

config :top, Top.FetchCurrentUser,
  secret_key: ""

config :top, Top.ImageProcessor,
  use_mozjpeg: true,
  cjpeg_path: ""
