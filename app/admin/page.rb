ActiveAdmin.register Page do
  menu priority: 5

  actions :all, except: [:show]

  permit_params :body, :slug

  index do
    column :body do |page|
      page.body.first(300)
    end
    column :slug
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :body
      f.input :slug, as: :string
    end
    f.actions
  end
end
