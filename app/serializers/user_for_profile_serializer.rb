class UserForProfileSerializer < UserSerializer
  self.root = :user

  attributes :can_edit

  def can_edit
    Users::CanEdit.new(scope, object).call
  end
end
