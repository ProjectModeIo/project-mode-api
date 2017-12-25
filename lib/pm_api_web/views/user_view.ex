require IEx
defmodule PmApiWeb.UserView do
  use PmApiWeb, :view
  alias PmApiWeb.UserView

  # def render("index.json", %{users: users}) do
  #   %{data: render_many(users, UserView, "user.json")}
  # end
  #
  # def render("show.json", %{user: user}) do
  #   %{data: render_one(user, UserView, "user.json")}
  # end

  def render("user.json", %{user: user}) do
    # IEx.pry
    %{id: user.id,
      email: user.email,
      firstname: user.firstname,
      lastname: user.lastname,
      tagline: user.tagline,
      roles: render_many(user.userroles, PmApiWeb.UserroleView, "userrole.json"),
      # roles: render_many(user.roles, PmApiWeb.RoleView, "role.json"),
      skills: render_many(user.userskills, PmApiWeb.UserskillView, "userskill.json"),
      interests: render_many(user.userinterests, PmApiWeb.UserinterestView, "userinterest.json")
    }
  end
end
