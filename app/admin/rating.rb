ActiveAdmin.register Rating do
  menu priority: 2

  actions :all, except: [:new, :create, :show]

  permit_params :title, :description, :status, :user_id, :section_id, tags_attributes: [:id, :name, :_destroy], items_attributes: [:id, :title, :description, :position, :_destroy]

  filter :title
  filter :status, as: :select, collection: Rating.statuses_i18n.invert
  filter :user
  filter :section

  member_action :unpublish, method: :put
  member_action :browser_notification, method: :post
  collection_action :main_page, method: :get
  collection_action :update_main_page, method: :put

  action_item :main_page, only: :index do
    link_to 'Рейтинги на главной', main_page_admin_ratings_path
  end

  index do
    column :title
    column :status do |rating|
      rating.status_i18n
    end
    column :user
    column :section
    actions defaults: true do |rating|
      a link_to 'В черновики', unpublish_admin_rating_path(rating), data: { method: :put, confirm: 'Точно?' } if rating.published?
      a link_to 'Пуш уведомления', browser_notification_admin_rating_path(rating), data: { method: :post, confirm: 'Точно?' } if rating.published?
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title, as: :string
      f.input :description
      f.input :section
      f.input :user
      f.has_many :tags, allow_destroy: true do |t|
        t.input :name, as: :string
      end
      f.has_many :items, allow_destroy: true, sortable: :position, sortable_start: 0 do |i|
        i.input :title, as: :string
        i.input :description
      end
      f.input :status, as: :select, collection: Rating.statuses_i18n.invert
    end
    f.actions
  end

  controller do
    def main_page
      @ratings = Rating.published.pluck(:title, :id)
      @current_ratings = Rating.on_main_page.map{ |rating| rating.slice(:main_page_position, :id).values }.to_h
      @positions = Rating.main_page_positions_i18n
    end

    def update_main_page
      MainPageRatings::Update.new(main_page_params).call
      redirect_to main_page_admin_ratings_path
    end

    def unpublish
      Ratings::Unpublish.new(resource).call
      redirect_to admin_ratings_path
    end

    def browser_notification
      BrowserNotifications::Sender.new(resource).send
      redirect_to admin_ratings_path
    end

    private

    def main_page_params
      params.require(:positions).permit(*Rating.main_page_positions.keys)
    end
  end
end
