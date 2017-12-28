defmodule PmApiWeb.ProjectinterestController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectinterest
  alias PmApi.Projectmode.Interest

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    projectinterests = Projectmode.list_projectinterests()
    render(conn, "index.json", projectinterests: projectinterests)
  end

  def create(conn, %{"project_id" => project_id, "name" => name}) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        project = Projectmode.get_project!(project_id)
        if project |> Projectmode.verify_project_owner(current_user) do
          {:ok, %Interest{}=interest} = Projectmode.find_or_create_interest_by(%{name: name})
          with {:ok, %Projectinterest{} = projectinterest } <- Projectmode.create_projectinterest(%{project_id: project_id, interest_id: interest.id}) do
            conn
            |> put_status(:created)
            |> render("show.json", projectinterest: projectinterest)
          end
        else
          conn
          |> render("error.json")
        end
      _ ->
        conn
        |> render("error.json")
    end
  end

  def show(conn, %{"id" => id}) do
    projectinterest = Projectmode.get_projectinterest!(id)
    render(conn, "show.json", projectinterest: projectinterest)
  end

  def update(conn, %{"id" => id, "projectinterest" => projectinterest_params}) do
    projectinterest = Projectmode.get_projectinterest!(id)

    with {:ok, %Projectinterest{} = projectinterest} <- Projectmode.update_projectinterest(projectinterest, projectinterest_params) do
      render(conn, "show.json", projectinterest: projectinterest)
    end
  end

  def delete(conn, %{"id" => id}) do
    projectinterest = Projectmode.get_projectinterest!(id)
    with {:ok, %Projectinterest{}} <- Projectmode.delete_projectinterest(projectinterest) do
      send_resp(conn, :no_content, "")
    end
  end
end
