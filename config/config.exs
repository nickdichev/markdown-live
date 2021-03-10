# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :markdown_live, MarkdownLiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZKqIDN8l+GJtEGtqWG3fNRXaJkplyXXdah3EI1ZiFqAsreQzLXJF78MOCj4rf0F7",
  render_errors: [view: MarkdownLiveWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: MarkdownLive.PubSub,
  live_view: [
    signing_salt: "0vUR+7zRvB+jFZS5xBmTFQ47ZcPAqYmY"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
