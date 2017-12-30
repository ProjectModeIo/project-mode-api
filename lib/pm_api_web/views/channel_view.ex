require IEx
defmodule PmApiWeb.ChannelView do
  use PmApiWeb, :view
  alias PmApiWeb.ChannelView

  def render("index.json", %{channels: channels}) do
    %{data: render_many(channels, ChannelView, "channeldetails.json")}
  end

  def render("show.json", %{channel: channel}) do
    %{data: render_one(channel, ChannelView, "channeldetails.json")}
  end

  def render("channel.json", %{channel: channel}) do
    %{
      id: channel.id,
      name: channel.name
    }
  end

  def render("channeldetails.json", %{channel: channel}) do
    %{
      id: channel.id,
      name: channel.name,
      role: render_one(channel.role, PmApiWeb.RoleView, "role_projonly.json"),
      skill: render_one(channel.skill, PmApiWeb.SkillView, "skill_projonly.json"),
      interest: render_one(channel.interest, PmApiWeb.InterestView, "interest_projonly.json")
    }
  end

  def render("room.json", %{channel: channel}) do
    %{
      id: channel.id,
      name: channel.name
    }
  end
end
