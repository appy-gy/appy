class CurrentUserSerializer < UserSerializer
  self.root = :user

  attributes :role
end
