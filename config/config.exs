# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pandatest,
  ecto_repos: [Pandatest.Repo]

# Configures the endpoint
config :pandatest, PandatestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4oDDs+EwZ6YL9X3m2Nyehggxr3ayVXV+ir6nAyNrF7gvuqVL1W7zpblcUf2e3DmZ",
  render_errors: [view: PandatestWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pandatest.PubSub,
  live_view: [signing_salt: "6m+q3AkZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
