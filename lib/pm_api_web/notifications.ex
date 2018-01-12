# PmApiWeb.Endpoint.broadcast("rooms:1","message_created",%{id: 10, text: "testing", user: %{username: "lala"}})
# defmodule PmApiWeb.Notifications.WebSocket do
#   defstruct [:topic, :event, :payload]
# end

defmodule Notifications.WebSocket do
  defstruct [:topic, :event, :payload]
end

defprotocol Notifications do
  def send(notification)
end

defimpl Notifications, for: Notifications.WebSocket do
  alias PmApiWeb.Endpoint

  def send(n) do
    Endpoint.broadcast(n.topic, n.event, n.payload)
  end
end

# create notification - changeset
# response = %{ notification: render_one(newnotification, PmApiWeb.NotificationView, "notification.json") }
# %Notifications.Websocket{topic: "user:"<>targetUser.id, event: "notification", payload: response}
# %Notifications.WebSocket{topic: "user:1", event: "new_member", payload: %{name: "Emiko"}}
# |> Notifications.send
