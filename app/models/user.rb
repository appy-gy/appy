class User < ActiveRecord::Base
  include Users::Auth

  mount_uploader :avatar, Users::AvatarUploader

  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy

  after_create :generate_avatar, unless: :avatar?

  private

  def generate_avatar
    Users::AvatarGenerator.new.generate { |avatar| self.avatar = avatar }
    save
  end
end
