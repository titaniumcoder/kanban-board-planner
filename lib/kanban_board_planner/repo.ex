defmodule KanbanBoardPlanner.Repo do
  use Ecto.Repo,
    otp_app: :kanban_board_planner,
    adapter: Ecto.Adapters.Postgres
end
