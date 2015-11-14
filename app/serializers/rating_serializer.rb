class RatingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :source, :published_at, :created_at,
    :status, :main_page_position, :slug, :image, :comments_count, :likes_count,
    :views_count

  has_one :user
  has_one :section
  has_many :tags

  def views_count
    object.views.value
  end

  def image
    object.image.url
  end
end
