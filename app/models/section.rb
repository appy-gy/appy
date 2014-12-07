class Section < ActiveRecord::Base
  has_many :ratings, dependent: :destroy

  validates :name, :color, presence: true
  validates :name, uniqueness: true
end
