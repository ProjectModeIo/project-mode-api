require IEx
defmodule PmApiWeb.UserController do
  import Plug.Conn
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.User
  alias PmApiWeb.Guardian

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    users = Projectmode.list_users()
    render(conn, "index.json", users: users |> Projectmode.user_preloads())
  end

  def create(conn, %{"user" => user_params}) do
    # changeset = User.registration_changeset(%User{}, user_params)
    case Projectmode.create_user(user_params) do
      {:ok, user} ->
        # user = user |> PmApi.Repo.preload([:userroles, :userskills, :userinterests])
        new_conn = Guardian.Plug.sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> render(PmApiWeb.SessionView, "show.json", user: user |> Projectmode.user_preloads(), jwt: jwt)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PmApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, params) do
    #id is technically username, edit this later
    case Projectmode.get_user_by(%{username: params["id"]}) do
      %User{} = user ->
        conn
        |> put_status(:ok)
        |> render("profile.json", user: user |> Projectmode.user_preloads())
      _ -> {:error, :not_found}
    end
  end

  def update(conn, %{"user" => user_params}) do
    # user = Projectmode.get_user!(id)
    #
    # with {:ok, %User{} = user} <- Projectmode.update_user(user, user_params) do
    #   render(conn, "show.json", user: user)
    # end
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, user} ->
        with {:ok, %User{} = user } <- Projectmode.update_user(user, user_params) do
          conn
          |> put_status(:ok)
          |> render("show.json", user: user |> Projectmode.user_preloads())
        end
      _ ->
        conn
        |> render("error.json")
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Projectmode.get_user!(id)
    with {:ok, %User{}} <- Projectmode.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
