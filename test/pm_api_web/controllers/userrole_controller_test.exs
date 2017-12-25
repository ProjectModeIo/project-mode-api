defmodule PmApiWeb.UserroleControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Userrole

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:userrole) do
    {:ok, userrole} = Projectmode.create_userrole(@create_attrs)
    userrole
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all userroles", %{conn: conn} do
      conn = get conn, userrole_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create userrole" do
    test "renders userrole when data is valid", %{conn: conn} do
      conn = post conn, userrole_path(conn, :create), userrole: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, userrole_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, userrole_path(conn, :create), userrole: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update userrole" do
    setup [:create_userrole]

    test "renders userrole when data is valid", %{conn: conn, userrole: %Userrole{id: id} = userrole} do
      conn = put conn, userrole_path(conn, :update, userrole), userrole: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, userrole_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, userrole: userrole} do
      conn = put conn, userrole_path(conn, :update, userrole), userrole: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete userrole" do
    setup [:create_userrole]

    test "deletes chosen userrole", %{conn: conn, userrole: userrole} do
      conn = delete conn, userrole_path(conn, :delete, userrole)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, userrole_path(conn, :show, userrole)
      end
    end
  end

  defp create_userrole(_) do
    userrole = fixture(:userrole)
    {:ok, userrole: userrole}
  end
end
