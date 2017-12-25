defmodule PmApiWeb.TeammemberView do
  use PmApiWeb, :view
  alias PmApiWeb.TeammemberView

  def render("index.json", %{teammembers: teammembers}) do
    %{data: render_many(teammembers, TeammemberView, "teammember.json")}
  end

  def render("show.json", %{teammember: teammember}) do
    %{data: render_one(teammember, TeammemberView, "teammember.json")}
  end

  def render("teammember.json", %{teammember: teammember}) do
    %{id: teammember.id}
  end
end
