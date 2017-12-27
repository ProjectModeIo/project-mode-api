defmodule PmApiWeb.ProjectstackController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectstack
  alias PmApi.Projectmode.Skill

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    projectstacks = Projectmode.list_projectstacks()
    render(conn, "index.json", projectstacks: projectstacks)
  end

  def create(conn, %{"project_id" => project_id, "name" => name}) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        project = Projectmode.get_project!(project_id)
        if project |> Projectmode.verify_project_owner(current_user) do
          {:ok, %Skill{}=skill} = Projectmode.find_or_create_skill_by(%{name: name})
          with {:ok, %Projectstack{} = projectstack } <- Projectmode.create_projectstack(%{project_id: project_id, skill_id: skill.id}) do
            conn
            |> put_status(:created)
            |> render("show.json", projectstack: projectstack)
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
    projectstack = Projectmode.get_projectstack!(id)
    render(conn, "show.json", projectstack: projectstack)
  end

  def update(conn, %{"id" => id, "projectstack" => projectstack_params}) do
    projectstack = Projectmode.get_projectstack!(id)

    with {:ok, %Projectstack{} = projectstack} <- Projectmode.update_projectstack(projectstack, projectstack_params) do
      render(conn, "show.json", projectstack: projectstack)
    end
  end

  def delete(conn, %{"id" => id}) do
    projectstack = Projectmode.get_projectstack!(id)
    with {:ok, %Projectstack{}} <- Projectmode.delete_projectstack(projectstack) do
      send_resp(conn, :no_content, "")
    end
  end
end
