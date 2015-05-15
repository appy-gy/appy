class RatingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :status, :comments_count,
    :likes_count, :can_edit

  has_one :user
  has_one :section
  has_one :like
  has_many :tags

  def can_edit
    Ratings::CanEdit.new(scope, object).call
  end
end
