defmodule PmApiWeb.ProjectcategoryControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectcategory

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:projectinterest) do
    {:ok, projectinterest} = Projectmode.create_projectinterest(@create_attrs)
    projectinterest
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all projectinterests", %{conn: conn} do
      conn = get conn, projectinterest_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create projectinterest" do
    test "renders projectinterest when data is valid", %{conn: conn} do
      conn = post conn, projectinterest_path(conn, :create), projectinterest: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, projectinterest_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, projectinterest_path(conn, :create), projectinterest: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update projectinterest" do
    setup [:create_projectinterest]

    test "renders projectinterest when data is valid", %{conn: conn, projectinterest: %Projectcategory{id: id} = projectinterest} do
      conn = put conn, projectinterest_path(conn, :update, projectinterest), projectinterest: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, projectinterest_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, projectinterest: projectinterest} do
      conn = put conn, projectinterest_path(conn, :update, projectinterest), projectinterest: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete projectinterest" do
    setup [:create_projectinterest]

    test "deletes chosen projectinterest", %{conn: conn, projectinterest: projectinterest} do
      conn = delete conn, projectinterest_path(conn, :delete, projectinterest)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, projectinterest_path(conn, :show, projectinterest)
      end
    end
  end

  defp create_projectinterest(_) do
    projectinterest = fixture(:projectinterest)
    {:ok, projectinterest: projectinterest}
  end
end
