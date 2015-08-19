class Tag < ActiveRecord::Base
  include PgSearch

  attr_accessor :number_of_uses

  pg_search_scope :search, against: :name, using: { tsearch: { prefix: true } }

  has_many :ratings_tags
  has_many :ratings, through: :ratings_tags

  validates :name, presence: true, uniqueness: true

  before_destroy :delete_ratings_tags

  private

  def delete_ratings_tags
    RatingsTag.where(tag: self).delete_all
  end
end
