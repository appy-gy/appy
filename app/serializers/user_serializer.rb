class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :facebook_link, :instagram_link,
    :created_at

  def avatar
    object.avatar.url
  end
end
