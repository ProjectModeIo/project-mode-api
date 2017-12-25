defmodule PmApiWeb.ProjectroleControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectrole

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:projectrole) do
    {:ok, projectrole} = Projectmode.create_projectrole(@create_attrs)
    projectrole
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all projectroles", %{conn: conn} do
      conn = get conn, projectrole_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create projectrole" do
    test "renders projectrole when data is valid", %{conn: conn} do
      conn = post conn, projectrole_path(conn, :create), projectrole: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, projectrole_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, projectrole_path(conn, :create), projectrole: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update projectrole" do
    setup [:create_projectrole]

    test "renders projectrole when data is valid", %{conn: conn, projectrole: %Projectrole{id: id} = projectrole} do
      conn = put conn, projectrole_path(conn, :update, projectrole), projectrole: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, projectrole_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, projectrole: projectrole} do
      conn = put conn, projectrole_path(conn, :update, projectrole), projectrole: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete projectrole" do
    setup [:create_projectrole]

    test "deletes chosen projectrole", %{conn: conn, projectrole: projectrole} do
      conn = delete conn, projectrole_path(conn, :delete, projectrole)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, projectrole_path(conn, :show, projectrole)
      end
    end
  end

  defp create_projectrole(_) do
    projectrole = fixture(:projectrole)
    {:ok, projectrole: projectrole}
  end
end
