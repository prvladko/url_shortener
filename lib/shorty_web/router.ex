defmodule ShortyWeb.Router do
  use ShortyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ShortyWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShortyWeb do
    pipe_through :browser

    # Public-facing UI
    # live "/", ShortLinkPublicLive, :index # TODO: uncomment later

    # Admin UI (generated by mix phx.gen.live)
    live "/short_links", ShortLinkLive.Index, :index
    live "/short_links/new", ShortLinkLive.Index, :new
    live "/short_links/:id/edit", ShortLinkLive.Index, :edit

    get "/", PageController, :index
  end

  # TODO: uncomment later
  # Catch-all routes must be at the end of the list.
  # scope "/", MyAppWeb do
  #   pipe_through :browser
  #
  #   get "/:key", ShortLinkRedirectController, :index
  # end

  # Other scopes may use custom stacks.
  # scope "/api", ShortyWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ShortyWeb.Telemetry
    end
  end
end
