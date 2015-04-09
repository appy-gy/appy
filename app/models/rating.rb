class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :section
  has_many :ratings_tags, dependent: :destroy
  has_many :tags, through: :ratings_tags
  has_many :options

  validates :title, :section, presence: true
end
