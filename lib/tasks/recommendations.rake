namespace :recommendations do
  desc 'Recalculate rating recommendations'
  task for_rating: :environment do
    recommendations = Ratings::Recommendations.new

    Rating.published.find_each do |rating|
      rating.update recommendations: recommendations.for(rating)
    end
  end
end
