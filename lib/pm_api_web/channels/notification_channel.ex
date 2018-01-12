require IEx
defmodule PmApiWeb.NotificationChannel do
  use PmApiWeb, :channel
  import Ecto.Query, warn: false
  alias PmApi.Projectmode.Channel

  def join("user:" <> user_id, _params, socket) do
    user = socket.assigns.current_user
    |> PmApi.Repo.preload([:notifications])

    response = %{
      notifications: Phoenix.View.render_many(user.notifications, PmApiWeb.NotificationView, "notification.json")
    }

    # IEx.pry
    {:ok, response, assign(socket, :user, user)}
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end
end
