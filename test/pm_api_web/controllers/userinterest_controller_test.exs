defmodule PmApiWeb.UserinterestControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Userinterest

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:userinterest) do
    {:ok, userinterest} = Projectmode.create_userinterest(@create_attrs)
    userinterest
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all userinterests", %{conn: conn} do
      conn = get conn, userinterest_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create userinterest" do
    test "renders userinterest when data is valid", %{conn: conn} do
      conn = post conn, userinterest_path(conn, :create), userinterest: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, userinterest_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, userinterest_path(conn, :create), userinterest: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update userinterest" do
    setup [:create_userinterest]

    test "renders userinterest when data is valid", %{conn: conn, userinterest: %Userinterest{id: id} = userinterest} do
      conn = put conn, userinterest_path(conn, :update, userinterest), userinterest: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, userinterest_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, userinterest: userinterest} do
      conn = put conn, userinterest_path(conn, :update, userinterest), userinterest: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete userinterest" do
    setup [:create_userinterest]

    test "deletes chosen userinterest", %{conn: conn, userinterest: userinterest} do
      conn = delete conn, userinterest_path(conn, :delete, userinterest)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, userinterest_path(conn, :show, userinterest)
      end
    end
  end

  defp create_userinterest(_) do
    userinterest = fixture(:userinterest)
    {:ok, userinterest: userinterest}
  end
end
