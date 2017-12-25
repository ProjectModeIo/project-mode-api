defmodule PmApiWeb.TeamprojectControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Teamproject

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:teamproject) do
    {:ok, teamproject} = Projectmode.create_teamproject(@create_attrs)
    teamproject
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teamprojects", %{conn: conn} do
      conn = get conn, teamproject_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create teamproject" do
    test "renders teamproject when data is valid", %{conn: conn} do
      conn = post conn, teamproject_path(conn, :create), teamproject: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, teamproject_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, teamproject_path(conn, :create), teamproject: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update teamproject" do
    setup [:create_teamproject]

    test "renders teamproject when data is valid", %{conn: conn, teamproject: %Teamproject{id: id} = teamproject} do
      conn = put conn, teamproject_path(conn, :update, teamproject), teamproject: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, teamproject_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, teamproject: teamproject} do
      conn = put conn, teamproject_path(conn, :update, teamproject), teamproject: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete teamproject" do
    setup [:create_teamproject]

    test "deletes chosen teamproject", %{conn: conn, teamproject: teamproject} do
      conn = delete conn, teamproject_path(conn, :delete, teamproject)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, teamproject_path(conn, :show, teamproject)
      end
    end
  end

  defp create_teamproject(_) do
    teamproject = fixture(:teamproject)
    {:ok, teamproject: teamproject}
  end
end
