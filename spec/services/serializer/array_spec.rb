require 'spec_helper'

RSpec.describe Serializer::Array do
  let(:array) { [Simple.new(1, 2), Simple.new(3, 4), Simple.new(5, 6)] }

  before :all do
    Simple = Struct.new :a, :b do
      alias_method :read_attribute_for_serialization, :send
    end

    SimpleSerializer = Class.new ActiveModel::Serializer do
      attributes :a
    end
  end

  after :all do
    Object.send :remove_const, :Simple
    Object.send :remove_const, :SimpleSerializer
  end

  subject { Serializer::Array.new(array).serialize }

  it 'serializes array' do
    hash = [{ a: 1 }, { a: 3 }, { a: 5 }]
    should eq hash
  end
end
