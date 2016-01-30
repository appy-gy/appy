ActiveAdmin.register_page 'Login' do
  menu label: 'Войти как', priority: 7

  page_action :as, method: :post

  content do
    render partial: 'form'
  end

  controller do
    include Sorcery::Controller

    def as
      user = User.find_by email: params[:email]
      return redirect_to :back unless user
      auto_login user
      redirect_to '/'
    end
  end
end
