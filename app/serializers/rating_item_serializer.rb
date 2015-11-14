class RatingItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :position, :mark,
    :rating_id, :image, :video, :image_width,
    :image_height

  has_one :vote

  def image
    object.image.url
  end
end
