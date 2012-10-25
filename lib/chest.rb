require "chest/configuration"
require "chest/model"
require "chest/repository"

module Chest
  class << self
    def configure(&block)
      yield(configuration) if block
    end

    def configuration
      @_configuration ||= Configuration.new
    end
  end
end
