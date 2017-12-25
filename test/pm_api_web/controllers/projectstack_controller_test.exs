defmodule PmApiWeb.ProjectstackControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Projectstack

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:projectstack) do
    {:ok, projectstack} = Projectmode.create_projectstack(@create_attrs)
    projectstack
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all projectstacks", %{conn: conn} do
      conn = get conn, projectstack_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create projectstack" do
    test "renders projectstack when data is valid", %{conn: conn} do
      conn = post conn, projectstack_path(conn, :create), projectstack: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, projectstack_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, projectstack_path(conn, :create), projectstack: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update projectstack" do
    setup [:create_projectstack]

    test "renders projectstack when data is valid", %{conn: conn, projectstack: %Projectstack{id: id} = projectstack} do
      conn = put conn, projectstack_path(conn, :update, projectstack), projectstack: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, projectstack_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, projectstack: projectstack} do
      conn = put conn, projectstack_path(conn, :update, projectstack), projectstack: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete projectstack" do
    setup [:create_projectstack]

    test "deletes chosen projectstack", %{conn: conn, projectstack: projectstack} do
      conn = delete conn, projectstack_path(conn, :delete, projectstack)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, projectstack_path(conn, :show, projectstack)
      end
    end
  end

  defp create_projectstack(_) do
    projectstack = fixture(:projectstack)
    {:ok, projectstack: projectstack}
  end
end
