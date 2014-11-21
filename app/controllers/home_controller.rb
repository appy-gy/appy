class HomeController < ApplicationController
  def index
    @ratings = Rating::FindForHome.new.call
    react_store 'RatingsStorage', serialize(@ratings)
  end
end
