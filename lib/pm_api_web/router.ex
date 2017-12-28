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
    resources "/projects", ProjectController, only: [:index, :show]
    resources "/roles", RoleController, only: [:index, :show]
    resources "/skills", SkillController, only: [:index, :show]
    resources "/interests", InterestController, only: [:index, :show]
    get "/projectslug/:slug", ProjectController, :showslug
  end

  scope "/api/v1", PmApiWeb do
    pipe_through [:api, :api_auth]

    #session
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    patch "/users/update", UserController, :update

    #user
    resources "/users", UserController, only: [:show, :delete]
    patch "/edituser", UserController, :update
    resources "/userroles", UserroleController, only: [:create, :delete]
    resources "/userskills", UserskillController, only: [:create, :delete]
    resources "/userinterests", UserinterestController, only: [:create, :delete]

    #project
    resources "/projects", ProjectController, only: [:create, :delete, :update]
    resources "/projectroles", ProjectroleController, only: [:create, :delete]
    resources "/projectskills", ProjectskillController, only: [:create, :delete]
    resources "/projectinterests", ProjectinterestController, only: [:create, :delete]

    #comments
    resources "/comments", CommentController, only: [:create]
  end
end
