defmodule PmApiWeb.RoleController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Role

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    roles = Projectmode.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %Role{} = role} <- Projectmode.create_role(role_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Projectmode.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Projectmode.get_role!(id)

    with {:ok, %Role{} = role} <- Projectmode.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Projectmode.get_role!(id)
    with {:ok, %Role{}} <- Projectmode.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
