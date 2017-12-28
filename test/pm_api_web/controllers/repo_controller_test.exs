defmodule PmApiWeb.RepoControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Github
  alias PmApi.Github.Repo

  @create_attrs %{commits_json: "some commits_json", totalcommits: 42}
  @update_attrs %{commits_json: "some updated commits_json", totalcommits: 43}
  @invalid_attrs %{commits_json: nil, totalcommits: nil}

  def fixture(:repo) do
    {:ok, repo} = Github.create_repo(@create_attrs)
    repo
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all repos", %{conn: conn} do
      conn = get conn, repo_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create repo" do
    test "renders repo when data is valid", %{conn: conn} do
      conn = post conn, repo_path(conn, :create), repo: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, repo_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "commits_json" => "some commits_json",
        "totalcommits" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, repo_path(conn, :create), repo: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update repo" do
    setup [:create_repo]

    test "renders repo when data is valid", %{conn: conn, repo: %Repo{id: id} = repo} do
      conn = put conn, repo_path(conn, :update, repo), repo: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, repo_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "commits_json" => "some updated commits_json",
        "totalcommits" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, repo: repo} do
      conn = put conn, repo_path(conn, :update, repo), repo: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete repo" do
    setup [:create_repo]

    test "deletes chosen repo", %{conn: conn, repo: repo} do
      conn = delete conn, repo_path(conn, :delete, repo)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, repo_path(conn, :show, repo)
      end
    end
  end

  defp create_repo(_) do
    repo = fixture(:repo)
    {:ok, repo: repo}
  end
end
