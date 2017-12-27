defmodule PmApiWeb.ProjectcategoryController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectcategory
  alias PmApi.Projectmode.Interest

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    projectcategories = Projectmode.list_projectcategories()
    render(conn, "index.json", projectcategories: projectcategories)
  end

  def create(conn, params) do
    # project can only update project if they are project creator
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        project = Projectmode.get_project!(params["project_id"])
        if project |> Projectmode.verify_project_owner(current_user) do
          {:ok, %Interest{}=interest} = Projectmode.find_or_create_interest_by(%{name: params["name"]})
          with {:ok, %Projectcategory{} = projectcategory } <- Projectmode.create_projectcategory(%{project_id: project.id, interest_id: interest.id}) do
            conn
            |> put_status(:created)
            |> render("show.json", projectcategory: projectcategory)
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
    projectcategory = Projectmode.get_projectcategory!(id)
    render(conn, "show.json", projectcategory: projectcategory)
  end

  def update(conn, %{"id" => id, "projectcategory" => projectcategory_params}) do
    projectcategory = Projectmode.get_projectcategory!(id)

    with {:ok, %Projectcategory{} = projectcategory} <- Projectmode.update_projectcategory(projectcategory, projectcategory_params) do
      render(conn, "show.json", projectcategory: projectcategory)
    end
  end

  def delete(conn, %{"id" => id}) do
    projectcategory = Projectmode.get_projectcategory!(id)
    with {:ok, %Projectcategory{}} <- Projectmode.delete_projectcategory(projectcategory) do
      send_resp(conn, :no_content, "")
    end
  end
end
