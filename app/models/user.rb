class User < ActiveRecord::Base
  extend FriendlyId
  include IdAsSlug
  include Users::Auth
  include Imagination::Field

  friendly_id :slug_candidates

  update_index 'global#user', :self

  image :avatar, versions: { normal: [480, 480], small: [100, 100] }
  image :background, versions: { normal: [960, 334] }, pad_color: '#21acd0'

  enum role: %w{member admin}

  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :browser_notification_subscriptions, dependent: :destroy

  after_create :generate_avatar, unless: :avatar?

  scope :with_name, -> { where.not name: nil }

  def to_s
    name or id
  end

  private

  def slug_candidates
    [:name, :id]
  end

  def should_generate_new_friendly_id?
    name? and name_changed? and uuid? slug
  end

  def generate_avatar
    Users::AvatarGenerator.new.generate { |avatar| self.avatar = avatar }
    save
  end
end
