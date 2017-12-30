defmodule PmApiWeb.MessageView do
  use PmApiWeb, :view
  alias PmApiWeb.MessageView

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{
      id: message.id,
      inserted_at: message.inserted_at,
      text: message.text,
      user: %{
        username: message.user.username
      }
    }
  end
end
