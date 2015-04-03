module Users
  class Create
    attr_reader :params

    def initialize params
      @params = params
    end

    def call
      User.create params
    end
  end
end
