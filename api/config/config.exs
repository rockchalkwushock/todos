# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :api,
  namespace: App,
  ecto_repos: [App.Repo],
  generators: [binary_id: true]

# Advanced configuration for database
config :api, App.Repo,
  migration_foreign_key: [column: :id, type: :binary_id],
  migration_primary_key: [name: :id, type: :binary_id],
  migration_timestamps: [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

# Configures the endpoint
config :api, AppWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: App.PubSub,
  live_view: [signing_salt: "/rXfxgzJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
