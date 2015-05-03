class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating, counter_cache: true

  validates :user, :rating, presence: true
  validates :user, uniqueness: { scope: :rating }
end
