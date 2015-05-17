class User < ActiveRecord::Base
  extend FriendlyId
  include Users::Auth

  friendly_id :slug_candidates

  mount_uploader :avatar, Users::AvatarUploader

  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :votes, dependent: :destroy

  after_create :generate_avatar, unless: :avatar?

  private

  def slug_candidates
    [:name, :id]
  end

  def should_generate_new_friendly_id?
    not slug? or (name? and name_changed? and slug =~ /\A\h{8}-(\h{4}-){3}\h{12}\z/)
  end

  def generate_avatar
    Users::AvatarGenerator.new.generate { |avatar| self.avatar = avatar }
    save
  end
end
