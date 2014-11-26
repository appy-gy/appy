require 'spec_helper'

RSpec.describe Serializer::Relation do
  let(:relation) { @model.where a: 1 }

  before :all do
    columns = -> t do
      t.integer :a
      t.integer :b
    end
    @model = FakeModelFactory.create columns: columns

    serializer = Class.new ActiveModel::Serializer do
      attributes :b
    end
    Object.const_set "#{@model.name}Serializer", serializer
  end

  after :all do
    Object.send :remove_const, "#{@model.name}Serializer"
    FakeModelFactory.remove @model
  end

  before do
    @model.create a: 1, b: 1
    @model.create a: 1, b: 2
    @model.create a: 2, b: 3
  end

  subject { Serializer::Relation.new(relation).serialize }

  it 'serializes relation' do
    hash = [{ b: 1 }, { b: 2 }]
    should eq hash
  end
end
