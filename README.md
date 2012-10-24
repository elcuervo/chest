# Chest

Separate your bussiness from your presistance

![Chest](http://www.em4miniatures.com/acatalog/TChestfrontweb.jpg)

## Installation

```bash
gem install chest
```

## Tutorial

```ruby
class User
  include Chest::Model

  attr_accessor :id, :name, :email
end

class UserRepository
  include Chest::Repository

  collection User
  attributes :name
end

user = User.new(
  name: "John",
  email: "john@doe.com"
)

UserRepository.save(user)

user.id
#=> 1
```
