class PageSerializer < ActiveModel::Serializer
  attributes :id, :body, :slug
end
