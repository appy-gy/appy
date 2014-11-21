module Serializer
  class Smart < Base
    def serialize **opts
      serializer = item.class.name.demodulize.prepend('Serializer::').constantize
      serializer.new(data).serialize(opts)
    end
  end
end
