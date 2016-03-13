class UserForCommentSerializer < ActiveModel::Serializer
  self.root = :user

  attributes :id, :name, :email, :avatar, :slug

  def avatar
    object.avatar_url
  end
end
