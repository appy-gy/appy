class Api::Private::ClientErrorsController < Api::Private::BaseController
  def create
    info = params[:info].slice(*%i{user_id url user_agent message filename lineno colno stack})
    ClientError.create info: info
    render json: { success: true }
  end

  private

  def client_error_params

  end
end
