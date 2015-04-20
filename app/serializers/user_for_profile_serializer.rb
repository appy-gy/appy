class UserForProfileSerializer < UserSerializer
  self.root = :user

  attributes :can_edit

  def can_edit
    policy.edit?
  end

  private

  def policy
    @policy ||= UserPolicy.new scope, object
  end
end