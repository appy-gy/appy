module Tags
  class Create
    attr_reader :name

    def initialize name
      @name = name
    end

    def call
      Tag.find_or_create_by name: name
    end
  end
end
