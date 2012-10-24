require_relative "../test_helper"

describe Chest::Model do
  it "should only add accesible attributes" do
    SomeModel = Class.new do
      include Chest::Model
      attr_accessor :name
    end

    some_model = SomeModel.new(name: "John", email: "john@doe.org")
    assert_equal "John", some_model.name
    assert_raises(NoMethodError) { some_model.email }
  end
end
