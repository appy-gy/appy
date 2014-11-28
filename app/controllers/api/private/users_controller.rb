module Api
  module Private
    class UsersController < ApplicationController
      def create
      end

      def update
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
