class Tag < ActiveRecord::Base
  extend FriendlyId

  update_index 'tags', :self

  friendly_id :slug_candidates

  has_many :ratings_tags
  has_many :ratings, through: :ratings_tags

  validates :name, presence: true, uniqueness: true

  before_validation :downcase_name
  before_destroy :delete_ratings_tags

  private

  def slug_candidates
    [:name]
  end

  def downcase_name
    self.name = name.mb_chars.downcase.to_s
  end

  def delete_ratings_tags
    RatingsTag.where(tag: self).delete_all
  end
end
