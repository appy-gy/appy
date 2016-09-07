class Rating < ActiveRecord::Base
  extend FriendlyId
  include IdAsSlug
  include Imagination::Field
  include Redis::Objects

  const :recommendations_limit, 3

  attr_accessor :like

  acts_as_paranoid

  friendly_id :slug_candidates

  counter :views

  image :image, versions: { normal: [960, 500], preview: [300, 200] }, pad_color: '#21acd0'

  belongs_to :user
  belongs_to :section
  has_many :ratings_tags, dependent: :destroy
  has_many :tags, through: :ratings_tags, after_remove: :cleanup_tag
  has_many :items, class_name: 'RatingItem', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  accepts_nested_attributes_for :tags, allow_destroy: true
  accepts_nested_attributes_for :items, allow_destroy: true

  enum status: %w{draft published}
  enum main_page_position: %w{top left right}

  validates :main_page_position, uniqueness: { allow_nil: true }

  before_save :set_published_at, if: :publishing?
  before_save :set_words, if: :publishing?
  before_save :set_recommendations, if: :publishing?

  scope :on_main_page, -> { where.not main_page_position: nil }

  private

  def slug_candidates
    [:title, :id]
  end

  def should_generate_new_friendly_id?
    publishing?
  end

  def set_published_at
    self.published_at = Time.current
  end

  def set_words
    self.words = Ratings::Keywords.for self
  end

  def set_recommendations
    self.recommendations = Ratings::Recommendations.new.for(self)
  end

  def publishing?
    status_changed? and status == 'published'
  end

  def cleanup_tag tag
    tag.destroy unless tag.ratings.present?
  end
end
