class UserForProfileSerializer < UserSerializer
  self.root = :user

  attributes :ratings_count, :comments_count, :can_edit

  def ratings_count
    Ratings::FindForUser.new(scope, object, nil).call.total_count
  end

  def comments_count
    object.comments.count
  end

  def can_edit
    Users::CanEdit.new(scope, object).call
  end
end
