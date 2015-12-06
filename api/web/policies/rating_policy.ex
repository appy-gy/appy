defmodule Top.RatingPolicy do
  def edit?(current_user, rating) do
    current_user.id == rating.user_id or current_user.role == :admin
  end

  def comment?(current_user, rating) do
    not is_nil(current_user) and rating.status == :published
  end
end
