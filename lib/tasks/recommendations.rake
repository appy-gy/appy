namespace :recommendations do
  desc 'Recalculate rating recommendations'
  task for_rating: :environment do
    ratings = Rating.published

    # TODO: WUT?
    ratings.each do |rating|
      rating.recommendations = Ratings::Recommendations.new(rating, ratings.where.not(id: rating)).recommendations.first(Rating::recommendations_limit)
    end
  end
end
