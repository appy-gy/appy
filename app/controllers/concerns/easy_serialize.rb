module EasySerialize
  extend ActiveSupport::Concern

  def serialize data, **opts
    Serializer::Smart.new(data).serialize(opts)
  end
end
