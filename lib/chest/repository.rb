module Chest
  module Repository
    class << self
      def included(mod)
        mod.extend self
      end
    end

    def attributes(*symbols)
      @_attributes ||= []
      @_attributes |= symbols
    end

    def save(model)
      attributes = {}
      list = @_attributes & model.methods.map(&:to_sym)
      list.each { |key, value| attributes[key] = model.send(key) }
      attributes
    end
  end
end
