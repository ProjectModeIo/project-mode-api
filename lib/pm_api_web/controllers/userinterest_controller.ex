defmodule PmApiWeb.UserinterestController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Userinterest
  alias PmApi.Projectmode.Interest

  action_fallback PmApiWeb.FallbackController

  # def index(conn, _params) do
  #   userinterests = Projectmode.list_userinterests()
  #   render(conn, "index.json", userinterests: userinterests)
  # end

  def create(conn, %{"name" => name}) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        with {:ok, %Interest{} = interest } <- Projectmode.find_or_create_interest_by(%{name: name}) do
          with {:ok, %Userinterest{} = userinterest } <- Projectmode.create_userinterest(%{user_id: current_user.id, interest_id: interest.id}) do
            userinterest = userinterest |> PmApi.Repo.preload([:interest])
            conn
            |> put_status(:created)
            |> render("show.json", userinterest: userinterest, user: current_user)
          end
        end
      _ ->
      conn
      |> render("error.json")
    end
  end

  # def show(conn, %{"id" => id}) do
  #   userinterest = Projectmode.get_userinterest!(id)
  #   render(conn, "show.json", userinterest: userinterest)
  # end
  #
  # def update(conn, %{"id" => id, "userinterest" => userinterest_params}) do
  #   userinterest = Projectmode.get_userinterest!(id)
  #
  #   with {:ok, %Userinterest{} = userinterest} <- Projectmode.update_userinterest(userinterest, userinterest_params) do
  #     render(conn, "show.json", userinterest: userinterest)
  #   end
  # end

  def delete(conn, %{"id" => id}) do
    case PmApiWeb.SessionController.get_logged_in_user(conn) do
      {:ok, current_user} ->
        userinterest = Projectmode.get_userinterest!(id)
        if to_string(current_user.id) == to_string(userinterest.user_id) do
          with {:ok, %Userinterest{}} <- Projectmode.delete_userinterest(userinterest) do
            conn
            |> render("deleted.json", old_id: id, user: current_user)
          end
        end
      _ ->
        conn
        |> render("error.json")
    end
  end
end
