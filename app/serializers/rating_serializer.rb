class RatingSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at

  has_one :section
end
