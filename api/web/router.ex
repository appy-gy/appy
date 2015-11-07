defmodule Top.Router do
  use Top.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Top do
    pipe_through :api

    scope "/private", Private, as: :private do
      resources "/sections", SectionController
    end
  end
end
