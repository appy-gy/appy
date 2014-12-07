class Rating < ActiveRecord::Base
  belongs_to :section
  has_many :ratings_tags, dependent: :destroy
  has_many :tags, through: :ratings_tags

  validates :title, :section, presence: true
end
