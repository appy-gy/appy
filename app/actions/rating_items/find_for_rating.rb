module RatingItems
  class FindForRating
    attr_reader :rating, :user

    def initialize rating, user
      @rating = rating
      @user = user
    end

    def call
      return items unless @user
      items.each { |item| set_vote item }
    end

    delegate :items, to: :rating

    private

    def set_vote item
      item.vote = votes[item.id]
    end

    def votes
      @votes ||= @user.votes.for(items).group_by(&:rating_item_id).transform_values(&:first)
    end
  end
end
