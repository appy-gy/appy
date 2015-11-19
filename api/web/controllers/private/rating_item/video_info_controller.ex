defmodule Top.Private.RatingItem.VideoInfoController do
  use Top.Web, :controller

  alias Top.VideoInfo

  def index(conn, %{"url" => url}) do
    info = VideoInfo.load url
    json conn, info
  end
end
