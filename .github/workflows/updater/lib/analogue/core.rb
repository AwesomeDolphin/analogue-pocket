require_relative 'metadata'

module Analogue
  class Core
    attr_reader :metadata

    def id
      "#{@metadata.author}.#{@metadata.shortname}"
    end

    def platform_id
      @metadata.platform_ids.first
    end

    def initialize(definition)
      @metadata = Metadata.new(definition.core.metadata)
    end
  end
end
