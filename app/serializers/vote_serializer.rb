class VoteSerializer < ActiveModel::Serializer
  attributes :id, :rating_item_id, :kind
end
