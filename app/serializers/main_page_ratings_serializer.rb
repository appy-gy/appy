class MainPageRatingsSerializer < ActiveModel::Serializer
  self.root = :ratings

  MainPageRatings.positions.each do |position|
    has_one position
  end
end
