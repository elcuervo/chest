# Chest

class User
  attr_reader :id
  attr_accessor :name, :email
end

class UserRepository
  include Chest::Repository
end

user = User.create(
  name: "John",
  email: "john@doe.com"
)

UserRepository.save(user)
