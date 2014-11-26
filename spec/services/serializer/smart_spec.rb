require 'spec_helper'

RSpec.describe Serializer::Smart do
  before :all do
    Simple = Struct.new :a, :b, :c do
      alias_method :read_attribute_for_serialization, :send
    end

    SimpleSerializer = Class.new ActiveModel::Serializer do
      attributes :a, :b
    end

    @object_serializer = Class.new ActiveModel::Serializer do
      self.root = :object

      attributes :b, :c
    end

    columns = -> t do
      t.integer :a
      t.integer :b
    end
    @model = FakeModelFactory.create columns: columns

    @model_serializer = Class.new ActiveModel::Serializer do
      attributes :a
    end

    serializer = Class.new ActiveModel::Serializer do
      attributes :b
    end
    Object.const_set "#{@model.name}Serializer", serializer
  end

  after :all do
    Object.send :remove_const, :Simple
    Object.send :remove_const, :SimpleSerializer

    Object.send :remove_const, "#{@model.name}Serializer"
    FakeModelFactory.remove @model
  end

  context 'object' do
    let(:object) { Simple.new 1, 2, 3 }

    subject { Serializer::Smart.new(object).serialize }

    it 'serializes object' do
      hash = { simple: { a: 1, b: 2 } }
      should eq hash
    end

    it 'use passed serializer' do
      result = Serializer::Smart.new(object).serialize(serializer: @object_serializer)
      hash = { object: { b: 2, c: 3 } }
      expect(result).to eq hash
    end
  end

  context 'array' do
    let(:array) { [Simple.new(1, 2, 3), Simple.new(4, 5, 6), Simple.new(7, 8, 9)] }

    subject { Serializer::Smart.new(array).serialize }

    it 'serializes array' do
      hash = [{ a: 1, b: 2 }, { a: 4, b: 5 }, { a: 7, b: 8 }]
      should eq hash
    end

    it 'use passed serializer' do
      result = Serializer::Smart.new(array).serialize(serializer: @object_serializer)
      hash = [{ b: 2, c: 3 }, { b: 5, c: 6 }, { b: 8, c: 9 }]
      expect(result).to eq hash
    end
  end

  context 'relation' do
    let(:relation) { @model.where a: 1 }

    before do
      @model.create a: 1, b: 1
      @model.create a: 1, b: 2
      @model.create a: 2, b: 3
    end

    subject { Serializer::Smart.new(relation).serialize }

    it 'serializes relation' do
      hash = [{ b: 1 }, { b: 2 }]
      should eq hash
    end

    it 'use passed serializer' do
      result = Serializer::Smart.new(relation).serialize(serializer: @model_serializer)
      hash = [{ a: 1 }, { a: 1 }]
      expect(result).to eq hash
    end
  end

  describe 'cache option' do
    it 'caches serialization result' do
      object = Simple.new 1, 2, 3
      hash = Serializer::Smart.new(object).serialize(cache: :object)
      cache = Rails.cache.read :object
      expect(cache).to eq hash
    end
  end
end
