class RatingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :published_at, :created_at,
    :status, :slug, :image, :comments_count, :likes_count,
    :can_edit, :can_see_comments

  has_one :user
  has_one :section
  has_one :like
  has_many :tags

  def can_edit
    Ratings::CanEdit.new(scope, object).call
  end

  def can_see_comments
    Ratings::CanSeeComments.new(scope, object).call
  end

  def image
    object.image.url
  end
end
