require 'json'
require 'ostruct'

require_relative 'binary_image'
require_relative 'platform'
require_relative 'file_repository'

module Analogue
  class PlatformRepository < FileRepository
    IMAGES_DIRECTORY = '_images'

    IMAGE_WIDTH = 521
    IMAGE_HEIGHT = 165

    def initialize(root_path)
      super(root_path)
    end

    def get_platform(id)
      definition = parse_json("#{id}.json")
      Platform.new(definition)
    end

    def get_image(id)
      image_file = "#{id}.bin"
      path = File.join(@root_path, IMAGES_DIRECTORY, image_file)
      unless File.exist?(path)
        return nil
      end
      BinaryImage.convert_image(path, IMAGE_WIDTH, IMAGE_HEIGHT)
    end
  end
end
