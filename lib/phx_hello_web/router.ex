defmodule PhxHelloWeb.Router do
  use PhxHelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhxHelloWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxHelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxHelloWeb do
  #   pipe_through :api
  # end
end
