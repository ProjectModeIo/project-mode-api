defmodule PmApiWeb.AccountControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Github
  alias PmApi.Github.Account

  @create_attrs %{commits_json: "some commits_json", organizations_json: "some organizations_json", projects_json: "some projects_json", totalcommits: 42, totalorganizations: 42, totalprojects: 42}
  @update_attrs %{commits_json: "some updated commits_json", organizations_json: "some updated organizations_json", projects_json: "some updated projects_json", totalcommits: 43, totalorganizations: 43, totalprojects: 43}
  @invalid_attrs %{commits_json: nil, organizations_json: nil, projects_json: nil, totalcommits: nil, totalorganizations: nil, totalprojects: nil}

  def fixture(:account) do
    {:ok, account} = Github.create_account(@create_attrs)
    account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get conn, account_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post conn, account_path(conn, :create), account: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, account_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "commits_json" => "some commits_json",
        "organizations_json" => "some organizations_json",
        "projects_json" => "some projects_json",
        "totalcommits" => 42,
        "totalorganizations" => 42,
        "totalprojects" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, account_path(conn, :create), account: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn, account: %Account{id: id} = account} do
      conn = put conn, account_path(conn, :update, account), account: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, account_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "commits_json" => "some updated commits_json",
        "organizations_json" => "some updated organizations_json",
        "projects_json" => "some updated projects_json",
        "totalcommits" => 43,
        "totalorganizations" => 43,
        "totalprojects" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put conn, account_path(conn, :update, account), account: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete conn, account_path(conn, :delete, account)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, account_path(conn, :show, account)
      end
    end
  end

  defp create_account(_) do
    account = fixture(:account)
    {:ok, account: account}
  end
end
