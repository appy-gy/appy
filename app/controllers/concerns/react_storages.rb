module ReactStorages
  extend ActiveSupport::Concern

  included do
    before_action :setup_react_storage_manager
    helper_method :add_react_storage, :react_storages
  end

  def add_react_storage name, data
    @react_storage_manager.add name, data
  end

  def react_storages
    @react_storage_manager.storages
  end

  private

  def setup_react_storage_manager
    @react_storage_manager = React::StorageManager.new
  end
end
