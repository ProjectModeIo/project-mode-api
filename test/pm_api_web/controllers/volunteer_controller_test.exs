defmodule PmApiWeb.VolunteerControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Network
  alias PmApi.Network.Volunteer

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:volunteer) do
    {:ok, volunteer} = Network.create_volunteer(@create_attrs)
    volunteer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all volunteers", %{conn: conn} do
      conn = get conn, volunteer_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create volunteer" do
    test "renders volunteer when data is valid", %{conn: conn} do
      conn = post conn, volunteer_path(conn, :create), volunteer: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, volunteer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, volunteer_path(conn, :create), volunteer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update volunteer" do
    setup [:create_volunteer]

    test "renders volunteer when data is valid", %{conn: conn, volunteer: %Volunteer{id: id} = volunteer} do
      conn = put conn, volunteer_path(conn, :update, volunteer), volunteer: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, volunteer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, volunteer: volunteer} do
      conn = put conn, volunteer_path(conn, :update, volunteer), volunteer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete volunteer" do
    setup [:create_volunteer]

    test "deletes chosen volunteer", %{conn: conn, volunteer: volunteer} do
      conn = delete conn, volunteer_path(conn, :delete, volunteer)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, volunteer_path(conn, :show, volunteer)
      end
    end
  end

  defp create_volunteer(_) do
    volunteer = fixture(:volunteer)
    {:ok, volunteer: volunteer}
  end
end
