class Section < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name

  has_many :ratings, dependent: :destroy

  validates :name, :color, :position, presence: true
  validates :name, uniqueness: true

  def to_s
    name
  end
end
