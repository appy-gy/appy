module React
  class Loader
    include HTTParty

    base_uri ENV['TOP_RENDERER_URL']

    def self.load component, props, storages
      post '/', query: { component: component, props: props, storages: storages }
    end
  end
end
