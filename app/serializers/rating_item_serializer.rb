class RatingItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :position, :mark,
    :image, :rating_id, :can_edit

  has_one :vote

  def can_edit
    RatingItems::CanEdit.new(scope, object).call
  end
end
