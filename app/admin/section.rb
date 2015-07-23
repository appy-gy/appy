ActiveAdmin.register Section do
  menu priority: 3

  actions :all, except: [:show]

  permit_params :name, :color, :position, :slug

  filter :name

  index do
    column :name
    column :color do |section|
      span section.color, style: "background: #{section.color}; color: white"
    end
    column :position
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name, as: :string
      f.input :color, as: :color
      f.input :position, as: :number
      f.input :slug, as: :string
    end
    f.actions
  end
end
