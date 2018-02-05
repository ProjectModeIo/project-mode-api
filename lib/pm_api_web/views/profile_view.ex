defmodule PmApiWeb.ProfileView do
  use PmApiWeb, :view
  alias PmApiWeb.ProfileView

  def render("access_token.json", %{github_access_token: github_access_token, account: account}) do
    %{
      access_token: github_access_token,
      account: render_one(account, PmApiWeb.AccountView, "account.json")
    }
  end

  def render("github_user_repos.json", %{data: data}) do
    %{
      data: data
    }
  end
end
