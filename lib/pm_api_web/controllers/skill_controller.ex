defmodule PmApiWeb.SkillController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Skill

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    skills = Projectmode.list_skills()
    render(conn, "index.json", skills: skills)
  end

  def create(conn, %{"skills" => skills_params}) do
    with {:ok, %Skill{} = skills} <- Projectmode.create_skills(skills_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", skills_path(conn, :show, skills))
      |> render("show.json", skills: skills)
    end
  end

  def show(conn, %{"id" => id}) do
    skills = Projectmode.get_skills!(id)
    render(conn, "show.json", skills: skills)
  end

  def update(conn, %{"id" => id, "skills" => skills_params}) do
    skills = Projectmode.get_skills!(id)

    with {:ok, %Skill{} = skills} <- Projectmode.update_skills(skills, skills_params) do
      render(conn, "show.json", skills: skills)
    end
  end

  def delete(conn, %{"id" => id}) do
    skills = Projectmode.get_skills!(id)
    with {:ok, %Skill{}} <- Projectmode.delete_skills(skills) do
      send_resp(conn, :no_content, "")
    end
  end
end
