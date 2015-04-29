module ActiveRecord
  module UuidByDefault
    module Adapter
      def create_table table_name, options = {}, &block
        options[:id] = :uuid unless options.has_key? :id
        super table_name, options, &block
      end

      def add_reference table_name, ref_name, options = {}
        options[:type] ||= :uuid
        super table_name, ref_name, options
      end
      alias :add_belongs_to :add_reference
    end
  end
end
