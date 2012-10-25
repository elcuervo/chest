require "chest/data_store"

module Chest
  module Repository
    class << self
      def included(mod)
        mod.extend self
      end
    end

    def find(id)
      data = data_store.find(collection_name, id)
      collection_class.new(data)
    end
    alias :[] :find

    def find_all
      (data_store.find_all(collection_name) || []).map do |item|
        collection_class.new(item)
      end
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

    def collection(collection_class)
      @_collection ||= collection_class
    end

    def to_collection_name(name)
      name.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    def collection_class
      @_collection
    end

    def collection_name
      @_collection_name ||= to_collection_name(collection_class.name)
    end

    def save(model)
      attributes = {}
      model_attributes = model.methods.map(&:to_sym)

      attributes_to_save = @_attributes & model_attributes
      attributes_to_save.each { |key, value| attributes[key] = model.send(key) }

      model_collection_name = to_collection_name(model.class.name)
      result_attributes = data_store.save(model_collection_name, attributes)
      result_attributes.each do |key, value|
        model.send("#{key}=", value) if model.respond_to?("#{key}=")
      end
      model
    end
  end
end
