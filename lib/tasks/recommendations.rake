namespace :recommendations do
  desc 'Recalculate rating recommendations'
  task for_rating: :environment do
    ratings = Rating.published.pluck(:id, :words)

    ratings.each do |rating_data|
      rating = Rating.find rating_data[0]
      rating.recommendations = Ratings::Recommendations.new(rating_data, ratings).recommendations.first(Rating::recommendations_limit).map(&:first)
      rating.save
    end
  end
end
