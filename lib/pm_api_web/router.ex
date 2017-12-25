defmodule PmApiWeb.Router do
  use PmApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug PmApiWeb.Guardian.AuthPipeline
  end

  # scope "/", PmApiWeb do
  #   pipe_through :browser # Use the default browser stack
  #
  #   get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.
  scope "/api/v1", PmApiWeb do
    pipe_through [:api]

    post "/sessions", SessionController, :create #login
    # get "/sessions/current", SessionController, :current #get current user
    resources "/users", UserController, only: [:create]
    resources "/roles", RoleController, only: [:index, :show]
    resources "/skills", SkillController, only: [:index, :show]
    resources "/interests", InterestController, only: [:index, :show]
  end

  scope "/api/v1", PmApiWeb do
    pipe_through [:api, :api_auth]

    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    patch "/users/update", UserController, :update
    resources "/users", UserController, only: [:show, :delete]

    resources "/userroles", UserroleController, only: [:create, :delete]
    resources "/userskills", UserskillController, only: [:create, :delete]
    resources "/userinterests", UserinterestController, only: [:create, :delete]
  end
end
