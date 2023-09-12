require 'json'
require 'ostruct'

require_relative 'platform'
require_relative 'file_repository'

module Analogue
  class PlatformRepository < FileRepository
    PLATFORM_DIRECTORY = 'Platforms'

    attr_reader :root_path

    def initialize(root_path)
      path = File.join(root_path, PLATFORM_DIRECTORY)
      super(path)
    end

    def get_platform(id)
      definition = parse_json("#{id}.json")
      Platform.new(definition)
    end
  end
end
