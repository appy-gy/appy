# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :top, Top.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "66ffcebe42b919fa6d3c12aa5aeaaeac3f1eaddf3d7c516a67a0772b26690c44767398e13408d5de1dd1332c7a0f49e0f354d63bb6dda5d8e9eeb5e7b7278330",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: Top.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :top, Top.Session,
  key: "_top_key",
  signing_salt: "307a74d1178a1e088695135486106905ac9e4b2f87a6d083e35d0ed46cacc62765a37e7a518efeed",
  encryption_salt: "259cae65154fd21fa9f9e3ce7dd5724abb5b5b52b9b599778eb441fdd4f22dc8b54fdddb55cdfcc8"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :exredis,
  host: "127.0.0.1",
  port: 6379,
  password: "",
  db: 0,
  reconnect: 5000,
  max_queue: :infinity
