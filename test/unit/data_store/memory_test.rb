require_relative "../../test_helper"

describe Chest::DataStore::Memory do
  before do
    MemoryStorableClass ||= Class.new do
      include Chest::Model

      attr_accessor :id, :name
    end

    MemoryStorableRepository ||= Class.new do
      include Chest::Repository

      collection MemoryStorableClass
      attributes :name
    end
  end

  it "should be able to find a model" do
    memory = MemoryStorableClass.new(name: "John")
    MemoryStorableRepository.save(memory)

    found_model = MemoryStorableRepository.find(memory.id)
    found_with_alias = MemoryStorableRepository[memory.id]

    assert_equal memory, found_model
    assert_equal found_with_alias, found_model
  end

  it "should list all the models" do
    models = MemoryStorableRepository.find_all

    assert_equal 1, models.size
    assert models.first.is_a?(MemoryStorableClass)
  end
end
