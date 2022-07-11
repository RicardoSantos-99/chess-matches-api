defmodule Chess.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Chess.Repo,
      # Start the Telemetry supervisor
      ChessWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Chess.PubSub},
      # Start the Endpoint (http/https)
      ChessWeb.Endpoint,
      # Start a worker by calling: Chess.Worker.start_link(arg)
      # {Chess.Worker, arg}
      {Mongo, [name: :mongo, database: "Pokemon", pool_size: 2]}
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Mongo.Connection.start_link(
  #   host: "localhost",
  #   port: 27017,
  #   database: "pokemon",
  #   pool_size: 10
  # )

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChessWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
