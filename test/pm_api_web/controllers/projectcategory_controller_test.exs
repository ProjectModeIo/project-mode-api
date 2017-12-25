defmodule PmApiWeb.ProjectcategoryControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectcategory

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:projectcategory) do
    {:ok, projectcategory} = Projectmode.create_projectcategory(@create_attrs)
    projectcategory
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all projectcategories", %{conn: conn} do
      conn = get conn, projectcategory_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create projectcategory" do
    test "renders projectcategory when data is valid", %{conn: conn} do
      conn = post conn, projectcategory_path(conn, :create), projectcategory: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, projectcategory_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, projectcategory_path(conn, :create), projectcategory: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update projectcategory" do
    setup [:create_projectcategory]

    test "renders projectcategory when data is valid", %{conn: conn, projectcategory: %Projectcategory{id: id} = projectcategory} do
      conn = put conn, projectcategory_path(conn, :update, projectcategory), projectcategory: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, projectcategory_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, projectcategory: projectcategory} do
      conn = put conn, projectcategory_path(conn, :update, projectcategory), projectcategory: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete projectcategory" do
    setup [:create_projectcategory]

    test "deletes chosen projectcategory", %{conn: conn, projectcategory: projectcategory} do
      conn = delete conn, projectcategory_path(conn, :delete, projectcategory)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, projectcategory_path(conn, :show, projectcategory)
      end
    end
  end

  defp create_projectcategory(_) do
    projectcategory = fixture(:projectcategory)
    {:ok, projectcategory: projectcategory}
  end
end
