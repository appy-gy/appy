class RatingForCommentSerializer < ActiveModel::Serializer
  self.root = :rating

  attributes :id, :title, :slug

  has_one :section
end
