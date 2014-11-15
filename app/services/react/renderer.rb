module React
  class Renderer
    const :pool_size, 10
    const :pool_timeout, 10

    def self.pool
      @pool ||= ConnectionPool.new(size: pool_size, timeout: pool_timeout) { new }
    end

    def self.render component, props, storages
      pool.with { |renderer| renderer.render component, props, storages }
    end

    def render component, props, storages
      Loader.load component, props, storages
    end
  end
end
