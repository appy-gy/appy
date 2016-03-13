class RatingForSearchSerializer < ActiveModel::Serializer
  self.root = :rating

  attributes :id, :title, :description, :image, :slug

  def image
    object.image_url
  end
end
