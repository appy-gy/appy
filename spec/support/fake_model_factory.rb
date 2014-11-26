module FakeModelFactory
  class << self
    attr_accessor :models
  end

  self.models = Set.new

  def self.create columns: -> {}, &block
    name = generate_name
    create_table name, &columns
    model = define_model name, &block
    models << model
    model
  end

  def self.remove model
    Object.send :remove_const, model.name
    ActiveRecord::Base.connection.drop_table model.table_name
    models.delete model
  end

  def self.cleanup
    models.each { |model| remove model }
  end

  private

  def self.generate_name
    SecureRandom.hex(8).prepend('a').singularize
  end

  def self.create_table name, &block
    ActiveRecord::Base.connection.create_table name.pluralize, &block
  end

  def self.define_model name, &block
    eval <<-CODE # rubocop:disable Lint/Eval
      class ::#{name.camelize} < ActiveRecord::Base
      end
    CODE
    model = name.camelize.constantize
    model.class_eval &block if block
    model
  end
end
