require IEx

defmodule PmApiWeb.GithubController do
  import Plug.Conn
  use PmApiWeb, :controller

  action_fallback PmApiWeb.FallbackController

  # receives code from github, signs the access token to the session and returns access token
  def github_callback(conn, %{"code" => github_code}) do
    with {:ok, current_user} <- PmApiWeb.SessionController.get_logged_in_user(conn) do
      with { :ok, github_access_token } <- PmApiWeb.Github.get_access_token(%{code: github_code}) do
        with {:ok, user_info} <- PmApiWeb.Github.get_user_info(github_access_token) do
          {:ok, user_info_json} = Poison.encode(user_info)
          with {:ok, account} <- PmApi.Github.create_or_update_account(current_user, %{
            user_id: current_user.id,
            access_token: github_access_token,
            user_info_json: user_info_json }) do
            conn
            # |> Plug.Conn.fetch_session()
            # |> Plug.Conn.put_session(:github_access_token, github_access_token)
            |> put_status(:ok)
            |> render("access_token.json", github_access_token: github_access_token, account: account)
            # |> put_resp_cookie("access_token", github_access_token)
          end
        end
      end
    end
  end

  def linkrepository(conn, %{"project_id" => project_id, "repo" => repo, "user" => githubuser}) do
    with {:ok, project} <- PmApi.AccessHandler.verify_resource_owner(conn, %{ project_id: project_id }) do
      with {:ok, commits_json } <- PmApiWeb.Github.make_request(%{repo: repo, githubuser: githubuser}) do
        with {:ok, repo } <- Github.create_repo(%{
          project_id: project_id, repo_url: "temporary",
          commits_json: "undo everything", totalcommits: 10 }) do #temporary stub!
          conn
          |> put_status(:created)
          |> render("show.json", repo: repo, commits: commits_json)
        end
      end
    end
  end
end
