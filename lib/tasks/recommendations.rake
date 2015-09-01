namespace :recommendations do
  desc 'Recalculate rating recommendations'
  task for_rating: :environment do
    ratings = Rating.published

    ratings.find_each do |rating|
      rating.recommendations = Ratings::Recommendations.new(rating, ratings.where.not(id: rating)).recommendations.first(Rating::recommendations_limit).map(&:id)
      rating.save
    end
  end
end
