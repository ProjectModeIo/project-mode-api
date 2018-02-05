require IEx
defmodule PmApiWeb.Github do
  use HTTPotion.Base

  def get_access_token(%{ code: session_code }) do
    endpoint = "https://github.com/login/oauth/access_token"
    data = [
      query: %{client_id: System.get_env("GITHUB_CLIENT_ID"), client_secret: System.get_env("GITHUB_CLIENT_SECRET"), code: session_code},
      headers: ["User-Agent": System.get_env("GITHUB_USER_AGENT"), "Accept": "application/json"]
    ]

    case HTTPotion.post(endpoint, data) do
      %HTTPotion.Response{} = response ->
        {:ok, body} = Poison.decode(response.body)
        if response.status_code == 200 and body["error"] == nil do
          {:ok, body["access_token"]}
        else
          {:error, :not_found}
        end
      %HTTPotion.ErrorResponse{} = error ->
        {:error, error}
    end
  end

  def get_access_token(%PmApi.Projectmode.User{} = user) do
    case PmApi.Profile.get_account_by(%{user_id: user.id}) do
      %PmApi.Profile.Account{} = account -> {:ok, account.access_token}
      _ -> {:error, :not_found}
    end
  end

  def get_user_info(access_token) do
    data = [
      query: %{ "access_token" => access_token},
      headers: ["User-Agent": System.get_env("GITHUB_USER_AGENT")]
    ]

    case HTTPotion.get("https://api.github.com/user", data) do
      %HTTPotion.Response{} = response ->
        {:ok, body} = Poison.decode(response.body)
        if response.status_code == 200 and body["error"] == nil do
          {:ok, body}
        else
          {:error, :not_found}
        end
      %HTTPotion.ErrorResponse{} = error ->
        IEx.pry
        {:error, error}
    end
  end

  def get_user_repos(%{github_user: github_user, github_access_token: github_access_token}) do
    data = [
      query: %{ "access_token" => github_access_token},
      headers: ["User-Agent": System.get_env("GITHUB_USER_AGENT")]
    ]

    case HTTPotion.get("https://api.github.com/users/"<>github_user<>"/repos", data) do
      %HTTPotion.Response{} = response ->
        {:ok, body} = Poison.decode(response.body)
        if response.status_code == 200 do
          {:ok, %{
            body: body,
            links: response.headers["link"]
          }}
        else
          {:error, :not_found}
        end
      %HTTPotion.ErrorResponse{} = error ->
        IEx.pry
        {:error, error}
    end
  end

  # verified links to github -> update projects table
  #PmApiWeb.Github.make_request(endpoint, %{append: "commits", query: %{ whatever queries }})
  #returns either {:ok, commits_json(string)} or {:error, "cant be reached"}
  def make_request(%{repo: repo, githubuser: githubuser}) do
    endpoint = "https://api.github.com/repos/" <> githubuser <> "/" <> repo <> "/commits"

    body = [
      query: %{client_id: System.get_env("GITHUB_CLIENT_ID"), client_secret: System.get_env("GITHUB_CLIENT_SECRET")},
      headers: ["User-Agent": System.get_env("GITHUB_USER_AGENT")]
    ]

    case HTTPotion.get(endpoint, body) do
      %HTTPotion.Response{} = response ->
        if response.status_code == 200 do
          {:ok, response.body}
        else
          {:error, :not_found}
        end
      %HTTPotion.ErrorResponse{} = error ->
        {:error, error}
    end
  end
end
