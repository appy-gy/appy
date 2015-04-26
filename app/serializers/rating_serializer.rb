class RatingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :status

  has_one :user
  has_one :section
  has_many :tags
end
