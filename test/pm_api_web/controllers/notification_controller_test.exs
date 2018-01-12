defmodule PmApiWeb.NotificationControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Chat
  alias PmApi.Chat.Notification

  @create_attrs %{link: "some link", message: "some message", read_at: ~N[2010-04-17 14:00:00.000000], seen: true}
  @update_attrs %{link: "some updated link", message: "some updated message", read_at: ~N[2011-05-18 15:01:01.000000], seen: false}
  @invalid_attrs %{link: nil, message: nil, read_at: nil, seen: nil}

  def fixture(:notification) do
    {:ok, notification} = Chat.create_notification(@create_attrs)
    notification
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all notifications", %{conn: conn} do
      conn = get conn, notification_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create notification" do
    test "renders notification when data is valid", %{conn: conn} do
      conn = post conn, notification_path(conn, :create), notification: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, notification_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "link" => "some link",
        "message" => "some message",
        "read_at" => ~N[2010-04-17 14:00:00.000000],
        "seen" => true}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, notification_path(conn, :create), notification: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update notification" do
    setup [:create_notification]

    test "renders notification when data is valid", %{conn: conn, notification: %Notification{id: id} = notification} do
      conn = put conn, notification_path(conn, :update, notification), notification: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, notification_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "link" => "some updated link",
        "message" => "some updated message",
        "read_at" => ~N[2011-05-18 15:01:01.000000],
        "seen" => false}
    end

    test "renders errors when data is invalid", %{conn: conn, notification: notification} do
      conn = put conn, notification_path(conn, :update, notification), notification: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete notification" do
    setup [:create_notification]

    test "deletes chosen notification", %{conn: conn, notification: notification} do
      conn = delete conn, notification_path(conn, :delete, notification)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, notification_path(conn, :show, notification)
      end
    end
  end

  defp create_notification(_) do
    notification = fixture(:notification)
    {:ok, notification: notification}
  end
end
