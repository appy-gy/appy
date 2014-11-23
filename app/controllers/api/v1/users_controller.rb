class Api::V1::UsersController < ApplicationController

  def create
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
