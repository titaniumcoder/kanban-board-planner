defmodule KanbanBoardPlannerWeb.PageController do
  use KanbanBoardPlannerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
