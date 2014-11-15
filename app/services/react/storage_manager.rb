module React
  class StorageManager
    attr_reader :storages

    def initialize
      @storages = {}
    end

    def add name, data
      @storages[name] = data.to_json
    end
  end
end
