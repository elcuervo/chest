require_relative "../../test_helper"

describe Chest::DataStore::Memory do
  it "should be able to find a model" do
    MemoryStorableClass = Class.new do
      include Chest::Model

      attr_accessor :id, :name
    end

    MemoryStorableRepository = Class.new do
      include Chest::Repository

      collection MemoryStorableClass
      attributes :name
    end

    memory = MemoryStorableClass.new(name: "John")
    MemoryStorableRepository.save(memory)

    found_model = MemoryStorableRepository.find(memory.id)
    assert_equal memory, found_model
  end
end
