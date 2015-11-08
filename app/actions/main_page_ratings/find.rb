class MainPageRatings
  class Find
    def call
      MainPageRatings.positions.each do |position|
        rating = on_main_page.find{ |rating| rating.main_page_position == position }
        ratings.send "#{position}=", rating
      end
      ratings
    end

    private

    def ratings
      @ratings ||= MainPageRatings.new
    end

    def on_main_page
      @on_main_page ||= Rating.on_main_page.to_a
    end
  end
end
