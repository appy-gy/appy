module EasySerialize
  extend ActiveSupport::Concern

  included do
    helper_method :serialize
  end

  def serialize data, **opts
    Serializer::Smart.new(data).serialize(opts)
  end
end
