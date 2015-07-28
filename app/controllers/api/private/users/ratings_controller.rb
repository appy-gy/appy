module Api
  module Private
    module Users
      class RatingsController < BaseController
        find :user
        check 'Users::CanSeeDrafts', :@user, only: [:drafts]

        Rating.statuses.each_key do |status|
          class_eval <<-CODE, __FILE__, __LINE__ + 1
            def #{status.pluralize}
              ratings = ::Ratings::FindForUser.new(current_user, @user, page: @page, status: :#{status}).call
              render json: ratings, meta: { pages_count: ratings.total_pages }
            end
          CODE
        end
      end
    end
  end
end
