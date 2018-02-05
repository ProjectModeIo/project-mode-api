require IEx
defmodule PmApiWeb.ProfileController do
  import Plug.Conn
  use PmApiWeb, :controller

  action_fallback PmApiWeb.FallbackController

  # receives code from github, signs the access token to the session and returns access token
  def github_callback(conn, %{"code" => github_code}) do
    with {:ok, current_user} <- PmApiWeb.SessionController.get_logged_in_user(conn) do
      with { :ok, github_access_token } <- PmApiWeb.Github.get_access_token(%{code: github_code}) do
        with {:ok, user_info} <- PmApiWeb.Github.get_user_info(github_access_token) do
          with {:ok, account} <- PmApi.Profile.update_github_info(current_user, %{github_access_token: github_access_token, github_info: user_info}) do
            conn
            |> put_status(:ok)
            |> render("access_token.json", github_access_token: github_access_token, account: account)
          end
        end
      end
    end
  end

  def linkrepository(conn, %{"project_id" => project_id, "github_access_token" => github_access_token, "github_user" => github_user }) do
    with {:ok, project} <- PmApi.AccessHandler.verify_resource_owner(conn, %{ project_id: project_id }) do
      with {:ok, project_repo_info } <- PmApiWeb.Github.get_user_repos(%{github_user: github_user, github_access_token: github_access_token}) do
        conn
        |> put_status(:ok)
        |> render("github_user_repos.json", data: project_repo_info)
      end
    end
  end
end
