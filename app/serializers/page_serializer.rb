class PageSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :slug
end
