defmodule PmApiWeb.TeammemberController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Teammember

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    teammembers = Projectmode.list_teammembers()
    render(conn, "index.json", teammembers: teammembers)
  end

  def create(conn, %{"teammember" => teammember_params}) do
    with {:ok, %Teammember{} = teammember} <- Projectmode.create_teammember(teammember_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", teammember_path(conn, :show, teammember))
      |> render("show.json", teammember: teammember)
    end
  end

  def show(conn, %{"id" => id}) do
    teammember = Projectmode.get_teammember!(id)
    render(conn, "show.json", teammember: teammember)
  end

  def update(conn, %{"id" => id, "teammember" => teammember_params}) do
    teammember = Projectmode.get_teammember!(id)

    with {:ok, %Teammember{} = teammember} <- Projectmode.update_teammember(teammember, teammember_params) do
      render(conn, "show.json", teammember: teammember)
    end
  end

  def delete(conn, %{"id" => id}) do
    teammember = Projectmode.get_teammember!(id)
    with {:ok, %Teammember{}} <- Projectmode.delete_teammember(teammember) do
      send_resp(conn, :no_content, "")
    end
  end
end
