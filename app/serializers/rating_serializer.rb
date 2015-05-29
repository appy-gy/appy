class RatingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :status, :slug, :image,
    :comments_count, :likes_count, :can_edit, :can_comment, :can_see_comments,
    :status

  has_one :user
  has_one :section
  has_one :like
  has_many :tags

  def can_edit
    Ratings::CanEdit.new(scope, object).call
  end

  def can_comment
    Ratings::CanComment.new(scope, object).call
  end

  def can_see_comments
    Ratings::CanSeeComments.new(scope, object).call
  end

  def image
    object.image.url
  end
end
