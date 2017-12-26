defmodule PmApiWeb.CommentController do
  use PmApiWeb, :controller

  alias PmApi.Projectmode
  alias PmApi.Projectmode.Comment

  action_fallback PmApiWeb.FallbackController

  def index(conn, _params) do
    comments = Projectmode.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    with {:ok, %Comment{} = comment} <- Projectmode.create_comment(comment_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", comment_path(conn, :show, comment))
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Projectmode.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Projectmode.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Projectmode.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Projectmode.get_comment!(id)
    with {:ok, %Comment{}} <- Projectmode.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
