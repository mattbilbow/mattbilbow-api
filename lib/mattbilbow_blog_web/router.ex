defmodule MattbilbowBlogWeb.Router do
  use MattbilbowBlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["http://localhost:3000"]
  end

  pipeline :api_protected do
    plug MattbilbowBlogWeb.Plugs.APIAuth
  end

  # Public API routes (no auth required)
  scope "/api", MattbilbowBlogWeb do
    pipe_through :api
    resources "/posts", PostController, only: [:index, :show]
    resources "/categories", CategoryController, only: [:index]
  end

  # Auth routes
  scope "/api/auth", MattbilbowBlogWeb.API do
    pipe_through :api
    post "/login", AuthController, :login
  end

  # Protected API routes (auth required)
  scope "/api", MattbilbowBlogWeb do
    pipe_through [:api, :api_protected]
    resources "/posts", PostController, only: [:create, :update, :delete]
  end
end