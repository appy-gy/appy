module React
  class Context
    include HTTParty

    base_uri ENV['TOP_RENDERER_URL']
    delegate :post, :delete, to: :class

    attr_reader :uuid, :storages

    def initialize
      @uuid = create!
      @storages = {}
    end

    def store path, data
      data = data.to_json
      @storages[path] = data
      post "/contexts/#{uuid}/storages", query: { path: path, data: data }
    end

    def render path, props
      post "/contexts/#{uuid}/render", query: { path: path, props: props.to_json }
    end

    def remove!
      delete "/contexts/#{uuid}"
    end

    private

    def create!
      post '/contexts'
    end
  end
end
