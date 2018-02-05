require IEx
defmodule PmApiWeb.VolunteerController do
  use PmApiWeb, :controller

  alias PmApi.Network
  alias PmApi.Network.Volunteer
  alias PmApi.Projectmode
  alias PmApi.Projectmode.Project

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    volunteers = Network.list_volunteers()
    render(conn, "index.json", volunteers: volunteers)
  end

  def create(conn, %{"project_id" => project_id}) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        with {:ok, %Project{} = project } <- Projectmode.get_project_by(%{id: project_id}) do
          # IEx.pry
          with {:ok, %Volunteer{} = volunteer } <- Network.create_or_update_volunteer(%{user_id: current_user.id, project_id: project.id}) do
            PmApiWeb.NotificationController.notify(volunteer, current_user)
            conn
            |> put_status(:created)
            |> render("show.json", volunteer: volunteer |> Projectmode.volunteerproject_preload()) #make volunteer_preloads
          end
        end
      _ ->
      conn
      |> render("error.json")
    end
  end

  def show(conn, %{"id" => id}) do
    volunteer = Network.get_volunteer!(id)
    render(conn, "show.json", volunteer: volunteer)
  end

  def update(conn, %{"id" => id, "volunteer" => volunteer_params}) do
    volunteer = Network.get_volunteer!(id)

    with {:ok, %Volunteer{} = volunteer} <- Network.update_volunteer(volunteer, volunteer_params) do
      render(conn, "show.json", volunteer: volunteer)
    end
  end

  def delete(conn, %{"id" => id}) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        volunteer = Network.get_volunteer!(id)
        if to_string(current_user.id) == to_string(volunteer.user_id) do
          with {:ok, %Volunteer{}} <- Network.delete_volunteer(volunteer) do
            send_resp(conn, :no_content, "")
            # conn
            # |> render("deleted.json", old_id: id, user: current_user |> Projectmode.user_preloads())
          end
        end
      _ ->
        conn
        |> render("error.json")
    end
  end
end
