class RatingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :source, :published_at, :created_at,
    :status, :slug, :image, :comments_count, :likes_count, :views_count,
    :can_edit

  has_one :user
  has_one :section
  has_one :like
  has_many :tags

  def views_count
    object.views.value
  end

  def can_edit
    Ratings::CanEdit.new(scope, object).call
  end

  def image
    object.image.url
  end
end
