defmodule PmApiWeb.ChannelController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Channel

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    channels = Projectmode.list_channels()
    render(conn, "index.json", channels: channels)
  end

  def create(conn, %{"channel" => channel_params}) do
    with {:ok, %Channel{} = channel} <- Projectmode.create_channel(channel_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", channel_path(conn, :show, channel))
      |> render("show.json", channel: channel)
    end
  end

  def show(conn, %{"id" => id}) do
    channel = Projectmode.get_channel!(id)
    render(conn, "show.json", channel: channel)
  end

  def update(conn, %{"id" => id, "channel" => channel_params}) do
    channel = Projectmode.get_channel!(id)

    with {:ok, %Channel{} = channel} <- Projectmode.update_channel(channel, channel_params) do
      render(conn, "show.json", channel: channel)
    end
  end

  def delete(conn, %{"id" => id}) do
    channel = Projectmode.get_channel!(id)
    with {:ok, %Channel{}} <- Projectmode.delete_channel(channel) do
      send_resp(conn, :no_content, "")
    end
  end
end
