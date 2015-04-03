class User < ActiveRecord::Base
  include Users::Auth

  mount_uploader :avatar, Users::AvatarUploader
end
