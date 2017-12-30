defmodule PmApiWeb.GithubView do
  use PmApiWeb, :view
  alias PmApiWeb.GithubView

  def render("access_token.json", %{github_access_token: github_access_token, account: account}) do
    %{
      access_token: github_access_token,
      account: render_one(account, PmApiWeb.AccountView, "account.json")
    }
  end
end
