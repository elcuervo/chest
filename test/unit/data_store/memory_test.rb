require_relative "../../test_helper"
require_relative "../../shared_examples"

describe Chest::DataStore::Memory do
  before do
    Chest.configure do |c|
      c.data_store = Chest::DataStore::Memory
    end
  end

  it_behaves_like "A DataStore"
end
