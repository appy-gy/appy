class Section < ActiveRecord::Base
  has_many :ratings

  validates :name, :color, presence: true
  validates :name, uniqueness: true
end
