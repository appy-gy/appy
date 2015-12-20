defmodule Top.VideoInfo do
  @providers [{:youtube, "youtu"}, {:vimeo, "vimeo"}]
  @vimeo_api_key Application.get_env(:top, __MODULE__)[:vimeo_api_key]

  def load(url) do
    info = parse url
    provider = provider_for info.host
    id = id_for provider, info.path, info.query
    thumbnail = thumbnail_for provider, id
    embed = embed_for provider, id
    %{id: id, provider: provider, thumbnail: thumbnail, embed: embed}
  end

  defp parse(url) do
    info = URI.parse url
    %{info | query: URI.decode_query(info.query || "")}
  end

  defp provider_for(host) do
    Enum.find(@providers, fn({_, pattern}) -> String.contains?(host, pattern) end)
    |> elem(0)
  end

  defp id_for(:youtube, _path, %{"v" => id}) do
    id
  end

  defp id_for(:youtube, path, _query) do
    path |> String.split("/") |> List.last
  end

  defp id_for(:vimeo, path, _query) do
    path |> String.split("/") |> List.last
  end

  defp thumbnail_for(:youtube, id) do
    "//i.ytimg.com/vi/#{id}/hqdefault.jpg"
  end

  defp thumbnail_for(:vimeo, id) do
    "https://api.vimeo.com/videos/#{id}/pictures"
    |> HTTPoison.get!(%{"Authorization" => "bearer #{@vimeo_api_key}"})
    |> Map.get(:body)
    |> Poison.decode!
    |> get_in(["data"])
    |> List.first
    |> get_in(["sizes"])
    |> Enum.max_by(&(&1["width"]))
    |> get_in(["link"])
  end

  defp embed_for(:youtube, id) do
    "//www.youtube.com/embed/#{id}"
  end

  defp embed_for(:vimeo, id) do
    "//player.vimeo.com/video/#{id}"
  end
end
