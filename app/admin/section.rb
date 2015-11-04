ActiveAdmin.register Section do
  menu priority: 3

  actions :all, except: [:show]

  permit_params :name, :color, :inverted_color, :position, :meta_title,
    :meta_description, :meta_keywords, :slug

  filter :name

  index do
    column :name
    column :color do |section|
      span section.color, style: "background: #{section.color}; color: white"
    end
    column :inverted_color do |section|
      span section.inverted_color, style: "background: #{section.inverted_color}; color: white"
    end
    column :position
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name, as: :string
      f.input :color, as: :color
      f.input :inverted_color, as: :color
      f.input :position, as: :number
      f.input :meta_title, as: :string
      f.input :meta_description
      f.input :meta_keywords, as: :string
      f.input :slug, as: :string
    end
    f.actions
  end
end
