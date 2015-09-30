class RatingForSearchSerializer < ActiveModel::Serializer
  self.root = :rating

  attributes :id, :title, :image, :slug

  def image
    object.image.url
  end
end
