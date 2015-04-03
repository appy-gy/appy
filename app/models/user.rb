class User < ActiveRecord::Base
  include Users::Auth

  mount_uploader :avatar, Users::AvatarUploader

  before_create :generate_avatar, unless: :avatar

  private

  def generate_avatar
    Users::AvatarGenerator.new.generate { |avatar| self.avatar = avatar }
  end
end
