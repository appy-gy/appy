class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :parent_id, :created_at

  has_one :user
end
