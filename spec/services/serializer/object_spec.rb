require 'spec_helper'

RSpec.describe Serializer::Object do
  context 'simple object' do
    let(:object) { Simple.new 1, 2, 3 }

    before :all do
      Simple = Struct.new :a, :b, :c do
        alias_method :read_attribute_for_serialization, :send
      end

      SimpleSerializer = Class.new ActiveModel::Serializer do
        attributes :a, :b
      end
    end

    after :all do
      Object.send :remove_const, :Simple
      Object.send :remove_const, :SimpleSerializer
    end

    subject { Serializer::Object.new(object).serialize }

    it 'serializes object' do
      hash = { simple: { a: 1, b: 2 } }
      should eq hash
    end
  end

  context 'active record' do
    let(:record) { @model.new a: 1, b: 2, c: 3 }

    before :all do
      columns = -> t do
        t.integer :a
        t.integer :b
        t.integer :c
      end
      @model = FakeModelFactory.create columns: columns

      serializer = Class.new ActiveModel::Serializer do
        attributes :a, :b
      end
      Object.const_set "#{@model.name}Serializer", serializer
    end

    after :all do
      Object.send :remove_const, "#{@model.name}Serializer"
      FakeModelFactory.remove @model
    end

    subject { Serializer::Object.new(record).serialize }

    it 'serializes record' do
      hash = { @model.name.underscore.to_sym => { a: 1, b: 2 } }
      should eq hash
    end
  end
end
