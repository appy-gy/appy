module SerializationHelper
  def serialize data, cache: false, **opts
    opts.reverse_merge! root: false, scope: current_user
    maybe_with_cache cache do
      data = data.call if data.kind_of? Proc
      case data
      when Array then serialize_array data, opts
      when ActiveRecord::Relation then serialize_relation data, opts
      else serialize_object data, opts
      end
    end
  end

  private

  def serialize_object object, **opts
    return {}.as_json if object.nil?
    serializer = opts.fetch(:serializer) { find_serializer object }
    opts.delete :root if opts[:root]
    serializer.new(object, opts).as_json
  end

  def serialize_array array, **opts
    return [].as_json if array.empty?
    serializer = opts.fetch(:serializer) { find_serializer array.first }
    opts.merge! each_serializer: serializer, scope: current_user
    ActiveModel::ArraySerializer.new(array, opts).as_json
  end

  def serialize_relation relation, **opts
    serializer = opts.fetch(:serializer) { find_serializer relation }
    opts.merge! each_serializer: serializer, scope: current_user
    ActiveModel::ArraySerializer.new(relation, opts).as_json
  end

  def find_serializer object
    class_name = case object
    when ActiveRecord::Relation then object.model.name
    else object.class.name.chomp('Decorator')
    end
    "#{class_name}Serializer".constantize
  end

  def maybe_with_cache key
    return yield unless key
    return Rails.cache.read key if Rails.cache.exist? key
    yield.tap { |json| Rails.cache.write key, json }
  end
end
