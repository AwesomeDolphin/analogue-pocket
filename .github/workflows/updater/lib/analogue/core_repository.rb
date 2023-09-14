require 'json'
require 'ostruct'

require_relative 'binary_image'
require_relative 'core'
require_relative 'data'
require_relative 'file_repository'

module Analogue
  class CoreRepository < FileRepository
    CORE_FILE = 'core.json'
    DATA_FILE = 'data.json'
    ICON_FILE = 'icon.bin'

    ICON_WIDTH = 36
    ICON_HEIGHT = 36

    def initialize(root_path)
      super(root_path)
    end

    def get_cores
      Dir.children(@root_path).map do |id|
        get_core(id)
      end
    end

    def get_data(id)
      path = File.join(id, DATA_FILE)
      definition = parse_json(path)
      Data.new(definition)
    end

    def get_icon(id)
      path = File.join(@root_path, id, ICON_FILE)
      unless File.exist?(path)
        return nil
      end
      BinaryImage.convert_image(path, ICON_WIDTH, ICON_HEIGHT)
    end

    private

    def get_core(id)
      path = File.join(id, CORE_FILE)
      definition = parse_json(path)
      Core.new(definition)
    end
  end
end
