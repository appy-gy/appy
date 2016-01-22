module Comments
  class Create
    attr_reader :rating, :params

    def initialize rating, params
      @rating = rating
      @params = params
    end

    def call
      collapse_newlines!
      comment = rating.comments.create params
    end

    private

    def collapse_newlines!
      return unless params[:body]
      params[:body].gsub! /\n{2,}/, "\n"
    end
  end
end
