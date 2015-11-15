class UserForProfileSerializer < UserSerializer
  self.root = :user

  attributes :background, :ratings_count, :comments_count

  def background
    object.background.url
  end

  def ratings_count
    Ratings::FindForUser.new(scope, object, nil).call.total_count
  end

  def comments_count
    object.comments.count
  end
end
