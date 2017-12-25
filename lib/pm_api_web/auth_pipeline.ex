defmodule PmApiWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :pm_api,
                              module: PmApiWeb.Guardian,
                              error_handler: PmApiWeb.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
end
