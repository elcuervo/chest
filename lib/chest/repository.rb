require "forwardable"
require "chest/data_store"

module Chest
  module Repository
    extend Forwardable

    class << self
      def included(mod)
        mod.extend self
      end
    end

    def find(id)
      data = data_store.find(collection_class.name, id)
      collection_class.new(data)
    end

    def store(current_store = Chest::DataStore::Memory, options = {})
      @_store ||= current_store.new(options)
    end

    def data_store
      store
    end

    def parent_attributes
      if superclass.ancestors.include?(Chest::Repository)
        superclass.attributes
      else
        []
      end
    end

    def attributes(*symbols)
      @_attributes ||= parent_attributes
      @_attributes |= symbols
    end

    def collection(class_name)
      @_collection ||= class_name
    end

    def collection_class
      @_collection
    end

    def save(model)
      attributes = {}
      model_attributes = model.methods.map(&:to_sym)

      attributes_to_save = @_attributes & model_attributes
      attributes_to_save.each { |key, value| attributes[key] = model.send(key) }

      result_attributes = data_store.save(model.class.to_s, attributes)
      result_attributes.each do |key, value|
        model.send("#{key}=", value) if model.respond_to?("#{key}=")
      end
      model
    end
  end
end
