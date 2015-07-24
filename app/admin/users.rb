ActiveAdmin.register User do
  menu priority: 2

  actions :all, except: [:show]

  permit_params :email, :password, :name, :avatar, :facebook_link,
    :instagram_link, :slug, :role

  filter :name
  filter :email
  filter :created_at

  index do
    column :name
    column :email
    column :role do |user|
      I18n.t "users.roles.#{user.role}"
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
      f.input :facebook_link, as: :string
      f.input :instagram_link, as: :string
      f.input :slug, as: :string
      f.input :role, as: :select, collection: User.roles.map{ |name, _| [I18n.t("users.roles.#{name}"), name] }
    end
    f.actions
  end
end
