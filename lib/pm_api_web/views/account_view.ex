require IEx
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
      avatar_url: account.avatar_url,
      github_info_json: account.github_info_json}
  end
end
