class SectionSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :color, :meta_title, :meta_description,
    :meta_keywords
end
