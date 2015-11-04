class SectionSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :color, :inverted_color, :meta_title,
    :meta_description, :meta_keywords
end
