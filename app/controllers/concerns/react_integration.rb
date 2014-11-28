module ReactIntegration
  extend ActiveSupport::Concern

  included do
    attr_reader :react_context

    before_action :create_react_context
    after_action :remove_react_context
  end

  def react_store path, data
    @react_context.store path, data
  end

  def react_storages
    @react_context.storages
  end

  private

  def create_react_context
    @react_context = React::Context.new
  end

  def remove_react_context
    @react_context.remove!
  end
end
