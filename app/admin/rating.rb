ActiveAdmin.register Rating do
  menu priority: 2

  actions :all, except: [:new, :create, :show]

  permit_params :title, :description, :status, :user_id, :section_id, tags_attributes: [:id, :name, :_destroy], items_attributes: [:id, :title, :description, :position, :_destroy]

  filter :title
  filter :status, as: :select, collection: Rating.statuses_i18n.invert
  filter :user
  filter :section

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
end
