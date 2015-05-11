module Queries
  class BulkUpdate
    attr_reader :model, :changes

    const :table_as, 't'
    const :values_as, 'v'

    def initialize model, changes
      @model = model
      @changes = changes
    end

    def call
      update_sql query
    end

    private

    delegate :table_name, :primary_key, to: :model
    delegate :update_sql, :quote, :quote_table_name, :quote_column_name, to: 'ActiveRecord::Base.connection'

    def query
      <<-SQL
        UPDATE #{quote_table_name table_name} as #{table_as} set
          #{set_part}
        FROM (values
          #{values_part}
        ) as #{values_as}(#{from_as_part})
        WHERE #{where_part};
      SQL
    end

    def set_part
      columns.map do |column|
        "#{quote_column_name column} = #{values_as}.#{quote_column_name column}"
      end.join(",\n")
    end

    def values_part
      changes.map do |id, changes|
        values = [id, *changes.values].map{ |value| quote value }.join(', ')
        "(#{values})"
      end.join(",\n")
    end

    def from_as_part
      [primary_key, *columns].map{ |column| quote_column_name column }.join(', ')
    end

    def where_part
      "#{table_as}.#{quote_column_name primary_key} = #{values_as}.#{quote_column_name primary_key}::#{primary_key_type}"
    end

    def columns
      @columns = changes.values.first.keys
    end

    def primary_key_type
      @primary_key_type ||= model.column_types[primary_key].type
    end
  end
end
