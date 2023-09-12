require 'json'
require 'ostruct'

require_relative 'core'
require_relative 'data'
require_relative 'file_repository'

module Analogue
  class CoreRepository < FileRepository
    CORES_DIRECTORY = 'Cores'

    CORE_FILE = 'core.json'
    DATA_FILE = 'data.json'

    attr_reader :root_path

    def initialize(root_path)
      path = File.join(root_path, CORES_DIRECTORY)
      super(path)
    end

    def get_cores
      Dir.children(@root_path).map do |id|
        get_core(id)
      end
    end

    def get_core(id)
      path = File.join(id, CORE_FILE)
      definition = parse_json(path)
      Core.new(definition)
    end

    def get_data(id)
      path = File.join(id, DATA_FILE)
      definition = parse_json(path)
      Data.new(definition)
    end
  end
end
