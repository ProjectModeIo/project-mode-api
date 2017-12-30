require IEx
defmodule PmApiWeb.RoomChannel do
  use PmApiWeb, :channel
  import Ecto.Query, warn: false
  alias PmApi.Projectmode.Channel

  def join("rooms:" <> room_id, _params, socket) do
    room = PmApi.Repo.get!(Channel, room_id)

    page =
      PmApi.Chat.Message
      |> where([m], m.channel_id == ^room.id)
      |> order_by([desc: :inserted_at, desc: :id])
      |> preload([:user])
      |> PmApi.Repo.paginate()

    response = %{
      room: Phoenix.View.render_one(room, PmApiWeb.ChannelView, "room.json"),
      messages: Phoenix.View.render_many(page.entries, PmApiWeb.MessageView, "message.json"),
      pagination: PmApi.PaginationHelpers.pagination(page)
    }

    # IEx.pry
    {:ok, response, assign(socket, :room, room)}
  end

  def handle_in("new_message", params, socket) do
    # IEx.pry
    changeset =
      socket.assigns.room
      |> Ecto.build_assoc(:messages, user_id: socket.assigns.current_user.id)
      |> PmApi.Chat.Message.changeset(params)

    case PmApi.Repo.insert(changeset) do
      {:ok, message} ->
        broadcast_message(socket, message)
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, Phoenix.View.render(PmApiWeb.ChangesetView, "error.json", changeset: changeset)}, socket}
    end
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end

  defp broadcast_message(socket, message) do
    message = PmApi.Repo.preload(message, :user)
    rendered_message = Phoenix.View.render_one(message, PmApiWeb.MessageView, "message.json")
    broadcast!(socket, "message_created", rendered_message)
  end
end
