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

  scope "/api/v1", PmApiWeb do
    pipe_through [:api]
    get "/track.gif", SessionController, :track
    post "/validate", UserController, :validate #validate unique constraints
    post "/sessions", SessionController, :create #login
    get "/load", SessionController, :load #loadAllThings in react app
    resources "/channels", ChannelController, only: [:index]
    resources "/users", UserController, only: [:create, :show]
    resources "/projects", ProjectController, only: [:index, :show]
    resources "/roles", RoleController, only: [:index, :show]
    resources "/skills", SkillController, only: [:index, :show]
    resources "/interests", InterestController, only: [:index, :show]

    get "/projectslug/:username/:slug", ProjectController, :showslug
    get "/channelslug/:slug", ChannelController, :showslug
  end

  scope "/api/v1", PmApiWeb do
    pipe_through [:api, :api_auth]

    #session
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh #setUser in react app
    patch "/users/update", UserController, :update

    #user
    resources "/users", UserController, only: [:delete]
    patch "/edituser", UserController, :update
    resources "/userroles", UserroleController, only: [:create, :delete]
    resources "/userskills", UserskillController, only: [:create, :delete]
    resources "/userinterests", UserinterestController, only: [:create, :delete]

    #project
    resources "/projects", ProjectController, only: [:create, :delete, :update]
    resources "/projectroles", ProjectroleController, only: [:create, :delete]
    resources "/projectskills", ProjectskillController, only: [:create, :delete]
    resources "/projectinterests", ProjectinterestController, only: [:create, :delete]
    resources "/watchedprojects", WatchedprojectController, only: [:create]
    resources "/volunteers", VolunteerController, only: [:create, :delete]
    #comments
    resources "/comments", CommentController, only: [:create]

    #notifications
    delete "/clear_all_notifications", NotificationController, :delete_all
    #link stuff like github
    post "/github_callback", ProfileController, :github_callback
    post "/github-link-repo", ProfileController, :linkrepository
    # resources "/github", RepoController, only: [:create, :delete, :show, :update]

  end
end
