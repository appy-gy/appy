class Rating < ActiveRecord::Base
  extend FriendlyId
  include Redis::Objects
  include IdAsSlug

  const :recommendations_limit, 3

  attr_accessor :like

  acts_as_paranoid

  friendly_id :slug_candidates

  counter :views

  mount_uploader :image, Ratings::RatingImageUploader

  belongs_to :user
  belongs_to :section
  has_many :ratings_tags, dependent: :destroy
  has_many :tags, through: :ratings_tags, after_remove: :cleanup_tag
  has_many :items, class_name: 'RatingItem', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :recommendations, class_name: 'Rating'

  accepts_nested_attributes_for :tags, allow_destroy: true
  accepts_nested_attributes_for :items, allow_destroy: true

  enum status: %w{draft published}

  after_create :generate_slug
  before_save :set_published_at, if: :publishing?

  # recommendation system
  def words
    ((title || '').scan(/[a-zA-Zа-яА-Я]{3,}/).to_set | tags.pluck(:name) | Array.wrap(section.try(:name))).map{ |word| word.mb_chars.downcase.to_s }.sort.to_set
  end

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

  def cleanup_tag tag
    tag.destroy unless tag.ratings.present?
  end
end
