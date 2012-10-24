require_relative "../test_helper"

describe Chest::Repository do
  it "should only store whitelisted attributes" do
    User = Class.new do
      include Chest::Model
      attr_accessor :name, :email, :address
    end

    UserRepository = Class.new do
      include Chest::Repository
      attributes :name, :email
    end

    user = User.new(
      name: "John",
      email: "john@doe.org",
      address: "Nowhere"
    )

    saved_attributes = UserRepository.save(user)
    assert_equal "John", saved_attributes.fetch(:name)
    assert_equal "john@doe.org", saved_attributes.fetch(:email)
    assert_raises(KeyError) { saved_attributes.fetch(:address) }
  end
end
