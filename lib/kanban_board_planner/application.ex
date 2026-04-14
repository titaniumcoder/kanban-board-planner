defmodule KanbanBoardPlanner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KanbanBoardPlannerWeb.Telemetry,
      KanbanBoardPlanner.Repo,
      {DNSCluster, query: Application.get_env(:kanban_board_planner, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: KanbanBoardPlanner.PubSub},
      # Start a worker by calling: KanbanBoardPlanner.Worker.start_link(arg)
      # {KanbanBoardPlanner.Worker, arg},
      # Start to serve requests, typically the last entry
      KanbanBoardPlannerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KanbanBoardPlanner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KanbanBoardPlannerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
