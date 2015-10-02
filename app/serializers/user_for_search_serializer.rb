class UserForSearchSerializer < ActiveModel::Serializer
  self.root = :user

  attributes :id, :name, :avatar, :slug

  def avatar
    object.avatar.url
  end
end
