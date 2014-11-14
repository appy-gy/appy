module React
  class Renderer
    const :pool_size, 10
    const :pool_timeout, 10

    def self.pool
      @pool ||= ConnectionPool.new(size: pool_size, timeout: pool_timeout) { new }
    end

    def self.render component, props
      pool.with { |renderer| renderer.render component, props }
    end

    def render component, props
      Loader.load component, props
    end
  end
end
