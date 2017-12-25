defmodule PmApiWeb.SkillsControllerTest do
  use PmApiWeb.ConnCase

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Skills

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:skills) do
    {:ok, skills} = Projectmode.create_skills(@create_attrs)
    skills
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all skills", %{conn: conn} do
      conn = get conn, skills_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create skills" do
    test "renders skills when data is valid", %{conn: conn} do
      conn = post conn, skills_path(conn, :create), skills: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, skills_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, skills_path(conn, :create), skills: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update skills" do
    setup [:create_skills]

    test "renders skills when data is valid", %{conn: conn, skills: %Skills{id: id} = skills} do
      conn = put conn, skills_path(conn, :update, skills), skills: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, skills_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, skills: skills} do
      conn = put conn, skills_path(conn, :update, skills), skills: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete skills" do
    setup [:create_skills]

    test "deletes chosen skills", %{conn: conn, skills: skills} do
      conn = delete conn, skills_path(conn, :delete, skills)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, skills_path(conn, :show, skills)
      end
    end
  end

  defp create_skills(_) do
    skills = fixture(:skills)
    {:ok, skills: skills}
  end
end
