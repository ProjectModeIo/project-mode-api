require IEx
defmodule PmApiWeb.NotificationController do
  use PmApiWeb, :controller

  alias PmApi.Chat
  alias PmApi.Chat.Notification
  alias PmApi.Projectmode

  action_fallback PmApiWeb.FallbackController

  def notify(created_thing, current_user) do
    with {:ok, notification} <- Projectmode.create_notification(created_thing, current_user) do
      response = %{
        notification: Phoenix.View.render_one(notification, PmApiWeb.NotificationView, "notification.json")
      }
      %Notifications.WebSocket{topic: "user:"<>to_string(notification.user_id), event: "notification", payload: response}
      |> Notifications.send
    end
  end

  def update(conn, %{"id" => id, "notification" => notification_params}) do
    notification = Chat.get_notification!(id)

    with {:ok, %Notification{} = notification} <- Chat.update_notification(notification, notification_params) do
      render(conn, "show.json", notification: notification)
    end
  end

  def delete(conn, %{"id" => id}) do
    notification = Chat.get_notification!(id)
    with {:ok, %Notification{}} <- Chat.delete_notification(notification) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete_all(conn, _params) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        current_user |> Projectmode.delete_notifications()
        send_resp(conn, :no_content, "")
      _ ->
        conn
        |> render("error.json")
    end
  end
end
