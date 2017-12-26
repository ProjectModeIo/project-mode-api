require IEx
defmodule PmApiWeb.UserskillController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Userskill
  alias PmApi.Projectmode.Skill

  action_fallback PmApiWeb.FallbackController

  # def index(conn, _params) do
  #   userskills = Projectmode.list_userskills()
  #   render(conn, "index.json", userskills: userskills)
  # end

  def create(conn, params) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        with {:ok, %Skill{} = skill } <- Projectmode.find_or_create_skill_by(%{name: params["name"]}) do
          with {:ok, %Userskill{} = userskill } <- Projectmode.create_userskill(%{user_id: current_user.id, skill_id: skill.id}) do
            userskill = userskill |> PmApi.Repo.preload([:skill])
            conn
            |> put_status(:created)
            |> render("show.json", userskill: userskill)
          end
        end
      _ ->
      conn
      |> render("error.json")
    end
  end

  # def show(conn, %{"id" => id}) do
  #   userskill = Projectmode.get_userskill!(id)
  #   render(conn, "show.json", userskill: userskill)
  # end

  # def update(conn, %{"id" => id, "userskill" => userskill_params}) do
  #   userskill = Projectmode.get_userskill!(id)
  #
  #   with {:ok, %Userskill{} = userskill} <- Projectmode.update_userskill(userskill, userskill_params) do
  #     render(conn, "show.json", userskill: userskill)
  #   end
  # end

  def delete(conn, %{"id" => id}) do
    userskill = Projectmode.get_userskill!(id)
    with {:ok, %Userskill{}} <- Projectmode.delete_userskill(userskill) do
      send_resp(conn, :no_content, "")
    end
  end
end
