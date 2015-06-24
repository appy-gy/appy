class Rating < ActiveRecord::Base
  extend FriendlyId

  attr_accessor :like

  friendly_id :slug_candidates

  mount_uploader :image, Ratings::RatingImageUploader

  belongs_to :user
  belongs_to :section
  has_many :ratings_tags, dependent: :destroy
  has_many :tags, through: :ratings_tags
  has_many :items, class_name: 'RatingItem', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  enum status: %w{draft published}

  after_create :generate_slug
  before_save :set_published_at, if: :publishing?

  private

  def slug_candidates
    [:title, :id]
  end

  def should_generate_new_friendly_id?
    persisted? and (not slug? or publishing?)
  end

  def generate_slug
    set_slug
    save
  end

  def set_published_at
    self.published_at = Time.current
  end

  def publishing?
    status_changed? and status == 'published'
  end
end
