module Api
  module Private
    class UserSessionsController < ApplicationController
      def new
        @user = login(params[:email], params[:password], params[:remember])
        render json: @user
      end

      def destroy
        logout
        redirect_to root_url
      end
    end
  end
end
