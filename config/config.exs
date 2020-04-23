# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phx_hello,
  ecto_repos: [PhxHello.Repo]

# Configures the endpoint
config :phx_hello, PhxHelloWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G3g+zr8RTG4OwS/mhJjutIY2HFKQEy7VjZIgpNAJRO/GBcbrHIw20T3+tB38Gt/v",
  render_errors: [view: PhxHelloWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhxHello.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "ovDy06Ws"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
