module Chest
  module DataStore
    class Memory < Chest::DataStore::Basic
      def initialize(options)
        @bucket = {}
      end

      def find(collection, id)
        @bucket[collection][id]
      end

      def save(collection, attributes)
        @bucket[collection] ||= []
        @bucket[collection] << attributes

        attributes[:id] = @bucket[collection].index(attributes)
        attributes
      end
    end
  end
end
