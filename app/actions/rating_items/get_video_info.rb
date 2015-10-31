module RatingItems
  class GetVideoInfo
    attr_reader :url

    def initialize url
      @url = url
    end

    def call
      info = VideoInfo.new url
      { id: info.video_id, provider: info.provider,
        thumbnail: info.thumbnail_large, embed: info.embed_url }
    rescue VideoInfo::UrlError
      {}
    end
  end
end
