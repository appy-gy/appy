module Api
  module Private
    module Ratings
      class TagsController < BaseController
        find :rating

        def create
          tag = ::Ratings::AddTag.new(@rating, params[:name]).call
          render json: tag
        end

        def destroy
          tag = ::Ratings::RemoveTag.new(@rating, params[:name]).call
          render json: tag
        end
      end
    end
  end
end
