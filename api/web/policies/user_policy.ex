defmodule Top.UserPolicy do
  def see_drafts?(current_user, _) when is_nil(current_user), do: false
  def see_drafts?(current_user, user), do: current_user.id == user.id
end
