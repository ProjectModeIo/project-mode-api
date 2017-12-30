require IEx

defmodule PmApi.AccessHandler do
  import Plug.Conn
  alias PmApiWeb.Guardian
  alias PmApi.Projectmode
  alias PmApi.Repo

  #resource = %{ project_id: project_id } - verifies that the current logged in user is the resource owner
  def verify_resource_owner(conn, resource) do
    case get_logged_in_user(conn) do
      {:ok, current_user} ->
        resource = get_resource(resource)
        |> verify_owner(current_user)
      _ -> {:error, "not logged in"}
    end
  end

  #returns {:ok, current_user}
  def get_logged_in_user(conn) do
    claims = Guardian.Plug.current_claims(conn)
    Guardian.resource_from_claims(claims)
  end

  #returns resource
  def get_resource(%{ project_id: project_id }) do
    Projectmode.get_project!(project_id)
  end

  # def get_resource(%{ team_id: team_id }) do
  #   IEx.pry
  # end

  #returns {:ok, resource} or {:error, "not the owner"}
  def verify_owner(resource, user) do
    resource = resource |> Repo.preload([:user])
    if to_string(resource.user.id) == to_string(user.id) do
      {:ok, resource}
    else
      {:error, "not the owner"}
    end
  end
end
