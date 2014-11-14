module React::Loader
  include HTTParty

  base_uri ENV['TOP_RENDERER_URL']

  def self.load component, props
    post '/', query: { component: component, props: props }
  end
end
