require IEx

defmodule PmApiWeb.SessionController do
  import Plug.Conn
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.User
  alias PmApiWeb.Guardian

  def create(conn, %{"user" => user_params}) do
    case authenticate(user_params) do
      {:ok, user} ->
        new_conn = Guardian.Plug.sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> render("show.json", user: user, jwt: jwt)
      :error ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json")
    end
  end

  def current(conn, _) do
    token = Enum.at(get_req_header(conn, "token"), 0)
    case Guardian.resource_from_token(token) do
      {:ok, user, _claims} ->
        conn
        |> render("show.json", user: user, jwt: token)
      :error ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json")
    end
  end

  def delete(conn, _) do
    jwt = Guardian.Plug.current_token(conn)
    IEx.pry
    # Guardian.revoke(jwt)
    #
    # conn
    # |> put_status(:ok)
    # |> render("delete.json")
  end

  def refresh(conn, _params) do
    claims = Guardian.Plug.current_claims(conn)
    {:ok, %User{} = user} = Guardian.resource_from_claims(claims)
    jwt = Guardian.Plug.current_token(conn)

    case Guardian.refresh(jwt) do
      {:ok, old_stuff, {new_jwt, new_claims}} ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user, jwt: new_jwt)
      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> render("forbidden.json", error: "Not authenticated")
    end
  end

  def load(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("load.json")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:forbidden)
    |> render(PmApiWeb.SessionView, "forbidden.json", error: "Not Authenticated")
  end

  def authenticate(%{"email" => email, "password" => password}) do
    user = Projectmode.get_user_by(%{email: String.downcase(email)})
    case check_password(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> Comeonin.Bcrypt.dummy_checkpw()
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end

  def get_logged_in_user(conn) do
    claims = Guardian.Plug.current_claims(conn)
    Guardian.resource_from_claims(claims)
  end
end
