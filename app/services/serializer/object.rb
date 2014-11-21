module Serializer
  class Object < Base
    private

    def serialization **opts
      -> do
        return {}.as_json if object.nil?
        serializer = opts.fetch(:serializer) { find_serializer }
        serializer.new(object, opts).as_json
      end
    end

    def class_name
      object.class.name
    end
  end
end
