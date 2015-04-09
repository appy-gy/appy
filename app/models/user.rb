class User < ActiveRecord::Base
  include Users::Auth

  mount_uploader :avatar, Users::AvatarUploader

  after_create :generate_avatar, unless: :avatar?

  has_many :ratings

  private

  def generate_avatar
    Users::AvatarGenerator.new.generate { |avatar| self.avatar = avatar }
    save
  end
end
