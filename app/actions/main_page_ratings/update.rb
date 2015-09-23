module MainPageRatings
  class Update
    attr_reader :positions

    def initialize positions
      @positions = positions
    end

    def call
      Rating.on_main_page.update_all(main_page_position: nil)
      positions.each do |position, id|
        Rating.find_by(id: id).try(:update, main_page_position: position)
      end
    end
  end
end
