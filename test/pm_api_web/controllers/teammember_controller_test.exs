defmodule PmApiWeb.TeammemberControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Teammember

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:teammember) do
    {:ok, teammember} = Projectmode.create_teammember(@create_attrs)
    teammember
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teammembers", %{conn: conn} do
      conn = get conn, teammember_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create teammember" do
    test "renders teammember when data is valid", %{conn: conn} do
      conn = post conn, teammember_path(conn, :create), teammember: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, teammember_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, teammember_path(conn, :create), teammember: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update teammember" do
    setup [:create_teammember]

    test "renders teammember when data is valid", %{conn: conn, teammember: %Teammember{id: id} = teammember} do
      conn = put conn, teammember_path(conn, :update, teammember), teammember: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, teammember_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, teammember: teammember} do
      conn = put conn, teammember_path(conn, :update, teammember), teammember: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete teammember" do
    setup [:create_teammember]

    test "deletes chosen teammember", %{conn: conn, teammember: teammember} do
      conn = delete conn, teammember_path(conn, :delete, teammember)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, teammember_path(conn, :show, teammember)
      end
    end
  end

  defp create_teammember(_) do
    teammember = fixture(:teammember)
    {:ok, teammember: teammember}
  end
end
