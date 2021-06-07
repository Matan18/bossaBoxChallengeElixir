# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bossabox,
  ecto_repos: [Bossabox.Repo]

config :bossabox, Bossabox.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :bossabox, BossaboxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "f2+ijWfY3m4QWgd3YOHwLPAZyjpyI03nIixMfkJiM3LKmTc/+CfkBunOUkuzmJVs",
  render_errors: [view: BossaboxWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Bossabox.PubSub,
  live_view: [signing_salt: "jBeK804Z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
