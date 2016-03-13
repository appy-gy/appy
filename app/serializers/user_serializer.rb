class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :created_at, :slug

  def avatar
    object.avatar_url
  end
end
