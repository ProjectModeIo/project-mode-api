require IEx
defmodule PmApiWeb.HttprequestsController do
  use PmApiWeb, :controller
  alias PmApiWeb.Httprequests
  action_fallback PmApiWeb.FallbackController

  def github(conn, params) do
    github_user_agent = System.get_env("GITHUB_USER_AGENT")
    github_client_id = System.get_env("GITHUB_CLIENT_ID")
    github_client_secret = System.get_env("GITHUB_CLIENT_SECRET")

    resp = HTTPotion.get "https://api.github.com/repos/mwei2509/corkly-react/commits",
      [query: %{client_id: github_client_id, client_secret: github_client_secret},
      headers: ["User-Agent": github_user_agent]]

    resp.body |> Poison.decode!
    IEx.pry
  end
end
