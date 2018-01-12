defmodule PmApiWeb.NotificationView do
  use PmApiWeb, :view
  alias PmApiWeb.NotificationView

  def render("index.json", %{notifications: notifications}) do
    %{data: render_many(notifications, NotificationView, "notification.json")}
  end

  def render("show.json", %{notification: notification}) do
    %{data: render_one(notification, NotificationView, "notification.json")}
  end

  def render("notification.json", %{notification: notification}) do
    %{id: notification.id,
      message: notification.message,
      seen: notification.seen,
      read_at: notification.read_at,
      link: notification.link}
  end
end
