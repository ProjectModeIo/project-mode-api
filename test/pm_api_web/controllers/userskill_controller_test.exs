defmodule PmApiWeb.UserskillControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Userskill

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:userskill) do
    {:ok, userskill} = Projectmode.create_userskill(@create_attrs)
    userskill
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all userskills", %{conn: conn} do
      conn = get conn, userskill_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create userskill" do
    test "renders userskill when data is valid", %{conn: conn} do
      conn = post conn, userskill_path(conn, :create), userskill: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, userskill_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, userskill_path(conn, :create), userskill: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update userskill" do
    setup [:create_userskill]

    test "renders userskill when data is valid", %{conn: conn, userskill: %Userskill{id: id} = userskill} do
      conn = put conn, userskill_path(conn, :update, userskill), userskill: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, userskill_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, userskill: userskill} do
      conn = put conn, userskill_path(conn, :update, userskill), userskill: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete userskill" do
    setup [:create_userskill]

    test "deletes chosen userskill", %{conn: conn, userskill: userskill} do
      conn = delete conn, userskill_path(conn, :delete, userskill)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, userskill_path(conn, :show, userskill)
      end
    end
  end

  defp create_userskill(_) do
    userskill = fixture(:userskill)
    {:ok, userskill: userskill}
  end
end
