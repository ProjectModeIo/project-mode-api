defmodule PmApiWeb.PageController do
  use PmApiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
