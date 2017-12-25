defmodule PmApiWeb.ProjectcategoryController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectcategory

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    projectcategories = Projectmode.list_projectcategories()
    render(conn, "index.json", projectcategories: projectcategories)
  end

  def create(conn, %{"projectcategory" => projectcategory_params}) do
    with {:ok, %Projectcategory{} = projectcategory} <- Projectmode.create_projectcategory(projectcategory_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", projectcategory_path(conn, :show, projectcategory))
      |> render("show.json", projectcategory: projectcategory)
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
