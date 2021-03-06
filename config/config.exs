# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :widgets,
  ecto_repos: [Widgets.Repo]

# Configures the endpoint
config :widgets, WidgetsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q/2FwmpTYlfhdMCW0fxtL11AFvxw5W4pdiFJcfWYcKE0H98FCAQ/q7+gzLSEaneB",
  render_errors: [view: WidgetsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Widgets.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Bamboo Settings
config :widgets, Widgets.Mailer,
  adapter: Bamboo.MailgunAdapter,
  api_key: System.get_env("MAILGUN_API"),
  domain: System.get_env("MAILGUN_DOMAIN")

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Get current environment with Application.get_env(:widgets, :env)
config :widgets, env: Mix.env()

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
