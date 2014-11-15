class HomeController < ApplicationController
  def index
    @test_data = { a: { c: 3 } }
  end
end
