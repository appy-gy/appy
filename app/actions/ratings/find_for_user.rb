module Ratings
  class FindForUser
    attr_reader :current_user, :user, :page, :status

    const :per_page, 12
    const :statuses, (Rating.statuses.keys.map(&:to_sym) + %i{all}).to_set

    def initialize current_user, user, page: nil, status: :all
      raise ArgumentError.new("Invalid status: #{status}") unless statuses.include? status

      @current_user = current_user
      @user = user
      @page = page
      @status = status
    end

    def call
      user.ratings.includes(:tags).order(updated_at: :desc)
        .public_send(status).page(page).per(per_page)
    end
  end
end
