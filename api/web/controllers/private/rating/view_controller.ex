defmodule Top.Private.Rating.ViewController do
  use Top.Web, :controller

  alias Top.Rating

  @expire 60

  def update(conn, %{"rating_id" => rating_id}) do
    rating = Repo.find Rating, rating_id
    ip = conn.remote_ip |> Tuple.to_list |> Enum.join(".")
    key = "ratingview:#{rating.id}:#{ip}"

    if Exredis.Api.exists(key) == 0 do
      Exredis.Api.set key, 1
      Exredis.Api.expire key, @expire
      Rating.views_increment rating
    end

    json conn, %{success: true}
  end
end
