defmodule Top.Router do
  use Top.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Top, as: :api do
    pipe_through :api

    scope "/private", Private, as: :private do
      resources "/ratings", RatingController, only: [:index, :show] do
        scope "/", Rating, as: :rating do
          resources "/similar", SimilarController, only: [:index]
          resources "/rating_items", RatingItemController, only: [:index]
          resources "/comments", CommentController, only: [:index]
        end
      end
      resources "/users", UserController, only: [:show] do
        scope "/", User, as: :user do
          resources "/ratings", RatingController, only: [:index]
          resources "/comments", CommentController, only: [:index]
        end
      end
      resources "/sections", SectionController, only: [:index, :show] do
        scope "/", Section, as: :section do
          resources "/ratings", RatingController, only: [:index]
        end
      end
      resources "/header_sections", HeaderSectionController, only: [:index]
      resources "/main_page_ratings", MainPageRatingController, only: [:index]
    end
  end
end
