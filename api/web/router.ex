defmodule Top.Router do
  use Top.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Top, as: :api do
    pipe_through :api

    scope "/private", Private, as: :private do
      resources "/sessions", SessionController, only: [:show], singleton: true do
        get "/check", SessionController, :check
      end
      resources "/users", UserController, only: [:update]
      resources "/ratings", RatingController, only: [:index, :show] do
        scope "/", Rating, as: :rating do
          resources "/similar", SimilarController, only: [:index]
          resources "/rating_items", RatingItemController, only: [:index]
          resources "/comments", CommentController, only: [:index]
          resources "/likes", LikeController, only: [:create, :delete], singleton: true
          resources "/view", ViewController, only: [:update], singleton: true
        end
      end
      scope "/rating_items", RatingItem do
        resources "/video_info", VideoInfoController, only: [:index]
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
      scope "/tags", Tag, as: :tag do
        resources "/popular", PopularController, only: [:index]
      end
      resources "/tags", TagController, only: [:index, :show] do
        scope "/", Tag, as: :tag do
          resources "/ratings", RatingController, only: [:index]
        end
      end
      scope "/pages", Page, as: :page do
        resources "/footer", FooterController, only: [:index]
      end
      resources "/pages", PageController, only: [:show]
      scope "/search" do
        get "/global", SearchController, :global
      end
    end
  end
end
