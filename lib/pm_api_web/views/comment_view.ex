require IEx
defmodule PmApiWeb.CommentView do
  use PmApiWeb, :view
  alias PmApiWeb.CommentView

  # def render("index.json", %{comments: comments}) do
  #   %{data: render_many(comments, CommentView, "comment.json")}
  # end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    #in projects comments, only include top level, rest will come with loop?

    %{
      id: comment.id,
      body: comment.body,
      project_id: comment.project_id,
      commenter: comment.user.username,
      parent_id: comment.parent_id,
      inserted_at: comment.inserted_at,
      updated_at: comment.updated_at
      # replies: render_many(comment.replies, PmApiWeb.CommentView, "comment.json")
    }
  end
end
