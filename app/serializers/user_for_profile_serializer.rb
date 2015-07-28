class UserForProfileSerializer < UserSerializer
  self.root = :user

  attributes :ratings_count, :comments_count, :can_edit,
    *Rating.statuses.keys.map{ |status| :"#{status}_ratings_count" }

  def ratings_count
    Rating.statuses.keys.sum { |status| send "#{status}_ratings_count" }
  end

  def comments_count
    object.comments.count
  end

  def can_edit
    Users::CanEdit.new(scope, object).call
  end

  def published_ratings_count
    @published_ratings_count ||= ratings_count_with_status :published
  end

  def draft_ratings_count
    @draft_ratings_count ||= begin
      return 0 unless Users::CanSeeDrafts.new(scope, object).call
      ratings_count_with_status :draft
    end
  end

  private

  def ratings_count_with_status status
    Ratings::FindForUser.new(scope, object, status: status).call.total_count
  end
end
