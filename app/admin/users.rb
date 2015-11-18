ActiveAdmin.register User do
  menu priority: 1

  actions :all, except: [:show]

  permit_params :email, :password, :name, :avatar, :slug, :role

  filter :name
  filter :email
  filter :created_at

  index do
    column :name
    column :email
    column :role do |user|
      user.role_i18n
    end
    column :created_at
    actions
  end

  form do |f|
    f.semantic_errors
    img src: f.object.avatar.url(:small)
    f.inputs do
      f.input :name, as: :string
      f.input :email, as: :email
      f.input :password
      f.input :avatar
      f.input :slug, as: :string
      f.input :role, as: :select, collection: User.roles_i18n.invert
    end
    f.actions
  end
end
