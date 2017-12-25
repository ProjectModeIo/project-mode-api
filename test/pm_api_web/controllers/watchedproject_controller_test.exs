defmodule PmApiWeb.WatchedprojectControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Watchedproject

  @create_attrs %{interestlevel: 42}
  @update_attrs %{interestlevel: 43}
  @invalid_attrs %{interestlevel: nil}

  def fixture(:watchedproject) do
    {:ok, watchedproject} = Projectmode.create_watchedproject(@create_attrs)
    watchedproject
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all watchedprojects", %{conn: conn} do
      conn = get conn, watchedproject_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create watchedproject" do
    test "renders watchedproject when data is valid", %{conn: conn} do
      conn = post conn, watchedproject_path(conn, :create), watchedproject: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, watchedproject_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "interestlevel" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, watchedproject_path(conn, :create), watchedproject: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update watchedproject" do
    setup [:create_watchedproject]

    test "renders watchedproject when data is valid", %{conn: conn, watchedproject: %Watchedproject{id: id} = watchedproject} do
      conn = put conn, watchedproject_path(conn, :update, watchedproject), watchedproject: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, watchedproject_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "interestlevel" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, watchedproject: watchedproject} do
      conn = put conn, watchedproject_path(conn, :update, watchedproject), watchedproject: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete watchedproject" do
    setup [:create_watchedproject]

    test "deletes chosen watchedproject", %{conn: conn, watchedproject: watchedproject} do
      conn = delete conn, watchedproject_path(conn, :delete, watchedproject)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, watchedproject_path(conn, :show, watchedproject)
      end
    end
  end

  defp create_watchedproject(_) do
    watchedproject = fixture(:watchedproject)
    {:ok, watchedproject: watchedproject}
  end
end
