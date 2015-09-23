class MainPageRatings
  include ActiveModel::SerializerSupport

  const :positions, Rating.main_page_positions.keys

  attr_accessor *positions

  def to_a
    positions.map { |position| send position }
  end
end
