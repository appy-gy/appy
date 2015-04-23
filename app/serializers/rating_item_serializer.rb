class RatingItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :position, :mark, :image, :rating_id
end
