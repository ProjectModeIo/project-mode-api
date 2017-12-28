defmodule PmApiWeb.AccountView do
  use PmApiWeb, :view
  alias PmApiWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id,
      projects_json: account.projects_json,
      commits_json: account.commits_json,
      organizations_json: account.organizations_json,
      totalprojects: account.totalprojects,
      totalcommits: account.totalcommits,
      totalorganizations: account.totalorganizations}
  end
end
