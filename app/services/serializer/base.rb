module Serializer
  class Base
    attr_reader :data

    def initialize data
      @data = data
    end

    def serialize cache: false, **opts
      maybe_with_cache cache, &serialization(opts)
    end

    private

    def item
      @item ||= data.kind_of?(Proc) ? data.call : data
    end

    def find_serializer
      @serializer ||= "#{class_name}Serializer".constantize
    end

    def maybe_with_cache key
      return yield unless key
      return Rails.cache.read key if Rails.cache.exist? key
      yield.tap { |json| Rails.cache.write key, json }
    end

    def self.inherited klass
      item_name = klass.name.demodulize.underscore
      alias_method item_name, :item
    end
  end
end
