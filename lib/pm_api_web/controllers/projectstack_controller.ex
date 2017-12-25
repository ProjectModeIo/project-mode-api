defmodule PmApiWeb.ProjectstackController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectstack

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    projectstacks = Projectmode.list_projectstacks()
    render(conn, "index.json", projectstacks: projectstacks)
  end

  def create(conn, %{"projectstack" => projectstack_params}) do
    with {:ok, %Projectstack{} = projectstack} <- Projectmode.create_projectstack(projectstack_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", projectstack_path(conn, :show, projectstack))
      |> render("show.json", projectstack: projectstack)
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
