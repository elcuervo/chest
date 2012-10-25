module Chest
  module DataStore
    class Memory < Chest::DataStore::Basic
      def initialize(options)
        @bucket = {}
      end

      def find(collection, id)
        @bucket[collection][id]
      end

      def find_all(collection)
        @bucket[collection]
      end

      def save(collection, attributes)
        @bucket[collection] ||= []
        @bucket[collection] << attributes

        attributes[:id] = @bucket[collection].index(attributes)
        attributes
      end

      def delete(collection, id)
        @bucket[collection].delete_at(id)
      end
    end
  end
end
