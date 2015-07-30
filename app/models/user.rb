class User < ActiveRecord::Base
  extend FriendlyId
  include IdAsSlug
  include Users::Auth

  friendly_id :slug_candidates

  mount_uploader :avatar, Users::AvatarUploader

  enum role: %w{member admin}

  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :votes, dependent: :destroy

  after_create :generate_avatar, unless: :avatar?

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
