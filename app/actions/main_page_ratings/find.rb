class MainPageRatings
  class Find
    def call
      MainPageRatings.positions.each do |position|
        rating = on_main_page.find{ |rating| rating.main_page_position == position } || popular.shift
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

    def popular
      @popular ||= Rating.where.not(id: on_main_page).where('published_at > ?', 3.days.ago).order(likes_count: :desc).limit(MainPageRatings.positions.count).to_a
    end
  end
end
