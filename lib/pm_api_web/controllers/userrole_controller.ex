require IEx
defmodule PmApiWeb.UserroleController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Userrole
  alias PmApi.Projectmode.Role
  alias PmApi.Projectmode.User
  alias PmApiWeb.Guardian

  action_fallback PmApiWeb.FallbackController

  # def index(conn, _params) do
  #   userroles = Projectmode.list_userroles()
  #   render(conn, "index.json", userroles: userroles)
  # end

  # def create(conn, params) do
  #   case PmApiWeb.SessionController.get_logged_in_user(conn) do
  #     {:ok, current_user} ->
  #       with {:ok, %Role{} = role } <- Projectmode.find_or_create_role_by(%{type: params["type"]}) do
  #         with {:ok, %Userrole{} = userrole } <- Projectmode.create_userrole(%{user_id: current_user.id, role_id: role.id}) do
  #           conn
  #           |> put_status(:created)
  #           |> render("show.json", userrole: userrole)
  #         end
  #       end
  #     _ ->
  #     conn
  #     |> render("error.json")
  #   end
  # end

  def create(conn, params) do
    # IEx.pry
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        with {:ok, %Role{} = role } <- Projectmode.find_or_create_role_by(%{type: params["type"]}) do
          # IEx.pry
          with {:ok, %Userrole{} = userrole } <- Projectmode.create_userrole(%{user_id: current_user.id, role_id: role.id}) do
            userrole = userrole |> PmApi.Repo.preload([:role])
            # IEx.pry
            conn
            |> put_status(:created)
            |> render("show.json", userrole: userrole)
          end
        end
      _ ->
        conn
        |> render("error.json")
    end
  end

  # def show(conn, %{"id" => id}) do
  #   userrole = Projectmode.get_userrole!(id)
  #   render(conn, "show.json", userrole: userrole)
  # end
  #
  # def update(conn, %{"id" => id, "userrole" => userrole_params}) do
  #   userrole = Projectmode.get_userrole!(id)
  #
  #   with {:ok, %Userrole{} = userrole} <- Projectmode.update_userrole(userrole, userrole_params) do
  #     render(conn, "show.json", userrole: userrole)
  #   end
  # end

  def delete(conn, %{"id" => id}) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        userrole = Projectmode.get_userrole!(id)
        if to_string(current_user.id) == to_string(userrole.user_id) do
          with {:ok, %Userrole{}} <- Projectmode.delete_userrole(userrole) do
            conn
            |> render("deleted.json", old_id: id, user: current_user)
          end
        end
      _ ->
        conn
        |> render("error.json")
    end
  end
end
