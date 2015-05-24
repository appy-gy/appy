class RatingItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :position, :mark,
    :image, :rating_id, :rating_slug, :can_edit, :image

  has_one :vote

  def rating_slug
    object.rating.slug
  end

  def can_edit
    RatingItems::CanEdit.new(scope, object).call
  end

  def image
    object.image.url
  end
end
