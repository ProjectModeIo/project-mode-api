defmodule PmApiWeb.AccountController do
  use PmApiWeb, :controller

  alias PmApi.Github
  alias PmApi.Github.Account

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    accounts = Github.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Github.create_account(account_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", account_path(conn, :show, account))
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Github.get_account!(id)
    render(conn, "show.json", account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Github.get_account!(id)

    with {:ok, %Account{} = account} <- Github.update_account(account, account_params) do
      render(conn, "show.json", account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Github.get_account!(id)
    with {:ok, %Account{}} <- Github.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end