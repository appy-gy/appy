class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating_item

  validates :kind, :user, :rating_item, presence: true
  validates :rating_item, uniqueness: { scope: :user }

  enum kind: %w{up down}

  scope :of, -> user { where user: user }
  scope :for, -> rating_item { where rating_item: rating_item }

  after_save :update_rating_item_mark
  after_destroy :update_rating_item_mark

  private

  def update_rating_item_mark
    RatingItems::UpdateMark.new(rating_item).call
  end
end
