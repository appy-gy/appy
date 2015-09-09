class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :parent_id, :rating_id, :created_at

  has_one :user, serializer: UserForCommentSerializer
  has_one :rating, serializer: RatingForCommentSerializer
end
