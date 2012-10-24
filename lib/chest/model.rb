module Chest
  module Model
    def initialize(attributes = {})
      current_methods = methods.map(&:to_s)
      attributes.each do |key, value|
        send("#{key}=", value) if current_methods.include?("#{key}=")
        if current_methods.include?(key)
          instance_variable_set("@#{key}", value)
        end
      end
    end

    def ==(model)
      self.id == model.id
    end
  end
end
