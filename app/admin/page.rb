ActiveAdmin.register Page do
  menu priority: 5

  actions :all, except: [:show]

  permit_params :title, :body, :slug

  index do
    column :title
    column :slug
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title, as: :string
      f.input :body
      f.input :slug, as: :string
    end
    f.actions
  end
end
