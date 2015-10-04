class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :ratings_count, :slug
end
