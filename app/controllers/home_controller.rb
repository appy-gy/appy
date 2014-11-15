class HomeController < ApplicationController
  def index
    @ratings = Rating::FindForHome.new.call
  end
end
