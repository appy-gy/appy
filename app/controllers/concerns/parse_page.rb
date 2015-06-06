module ParsePage
  extend ActiveSupport::Concern

  included do
    before_action :parse_page
  end

  def parse_page
    return unless params[:page]
    @page = Integer params[:page]
  rescue
  end
end
