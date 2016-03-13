class RatingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :source, :published_at, :created_at,
    :status, :main_page_position, :slug, :image, :comments_count, :likes_count

  has_one :user
  has_one :section
  has_one :like
  has_many :tags

  def image
    object.image_url
  end
end
