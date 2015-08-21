ActiveAdmin.register ::Comment do
  menu priority: 4

  actions :all, except: [:new, :create, :show]

  permit_params :body, :user_id

  filter :body
  filter :user
  filter :rating

  index do
    column :body
    column :user
    column :rating
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :body
      f.input :user
    end
    f.actions
  end
end
