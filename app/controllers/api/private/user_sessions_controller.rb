module Api
  module Private
    class UserSessionsController < ApplicationController
      def create
        @user = login *params[:user_session].values_at(:email, :password, :remember)
        render json: @user
      end

      def destroy
        logout
        redirect_to root_url
      end
    end
  end
end
