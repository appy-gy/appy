ActiveAdmin.register Rating do
  menu priority: 2

  actions :all, except: [:new, :create, :show]

  permit_params :title, :description, :status, :user_id, :section_id, tags_attributes: [:id, :name, :_destroy], items_attributes: [:id, :title, :description, :position, :_destroy]

  filter :title
  filter :status, as: :select, collection: Rating.statuses_i18n.invert
  filter :user
  filter :section

  collection_action :main_page, method: :get
  collection_action :update_main_page, method: :put

  action_item :main_page do
    link_to 'Рейтинги на главной', main_page_admin_ratings_path
  end

  index do
    column :title
    column :status do |rating|
      rating.status_i18n
    end
    column :user
    column :section
    actions
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

    private

    def main_page_params
      params.require(:positions).permit(*Rating.main_page_positions.keys)
    end
  end
end
