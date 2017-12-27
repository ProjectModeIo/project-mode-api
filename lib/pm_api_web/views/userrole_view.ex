defmodule PmApiWeb.UserroleView do
  use PmApiWeb, :view
  alias PmApiWeb.UserroleView

  def render("index.json", %{userroles: userroles}) do
    %{data: render_many(userroles, UserroleView, "userrole.json")}
  end

  def render("show.json", %{userrole: userrole}) do
    %{data: render_one(userrole, UserroleView, "userrole.json")}
  end

  def render("userrole.json", %{userrole: userrole}) do
    userrole = userrole |> PmApi.Repo.preload([:role])
    %{
      id: userrole.id,
      type: userrole.role.type
    }
  end

  def render("deleted.json", %{old_id: old_id, user: user}) do
    %{
      id: old_id,
      feed: render_one(user, PmApiWeb.UserView, "feed.json")
    }
  end
end
