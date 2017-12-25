defmodule PmApiWeb.InterestController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Interest

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    interests = Projectmode.list_interests()
    render(conn, "index.json", interests: interests)
  end

  def create(conn, %{"interest" => interest_params}) do
    with {:ok, %Interest{} = interest} <- Projectmode.create_interest(interest_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", interest_path(conn, :show, interest))
      |> render("show.json", interest: interest)
    end
  end

  def show(conn, %{"id" => id}) do
    interest = Projectmode.get_interest!(id)
    render(conn, "show.json", interest: interest)
  end

  def update(conn, %{"id" => id, "interest" => interest_params}) do
    interest = Projectmode.get_interest!(id)

    with {:ok, %Interest{} = interest} <- Projectmode.update_interest(interest, interest_params) do
      render(conn, "show.json", interest: interest)
    end
  end

  def delete(conn, %{"id" => id}) do
    interest = Projectmode.get_interest!(id)
    with {:ok, %Interest{}} <- Projectmode.delete_interest(interest) do
      send_resp(conn, :no_content, "")
    end
  end
end
