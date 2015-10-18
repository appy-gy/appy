class Section < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name

  has_many :ratings, dependent: :destroy

  validates :name, :color, :position, :meta_title, :meta_description,
    :meta_keywords, presence: true
  validates :name, uniqueness: true

  def to_s
    name
  end
end
