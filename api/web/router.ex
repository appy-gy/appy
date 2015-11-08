defmodule Top.Router do
  use Top.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Top, as: :api do
    pipe_through :api

    scope "/private", Private, as: :private do
      resources "/sections", SectionController, only: [:index, :show]
      resources "/header_sections", HeaderSectionController, only: [:index]
      resources "/main_page_ratings", MainPageRatingController, only: [:index]
    end
  end
end
