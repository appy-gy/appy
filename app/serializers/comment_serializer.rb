class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :parent_id, :rating_id, :rating_slug, :created_at

  has_one :user

  def rating_slug
    object.rating.slug
  end
end
