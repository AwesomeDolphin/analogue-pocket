require_relative 'core_repository'
require_relative 'platform_repository'

module Analogue
  class OpenFPGAService
    CORES_DIRECTORY = 'Cores'
    PLATFORMS_DIRECTORY = 'Platforms'

    attr_reader :core_repository, :platform_repository

    def initialize(root_path)
      cores_path = File.join(root_path, CORES_DIRECTORY)
      @core_repository = CoreRepository.new(cores_path)

      platforms_path = File.join(root_path, PLATFORMS_DIRECTORY)
      @platform_repository = PlatformRepository.new(platforms_path)
    end

    def export_icon(id, path)
      icon = @core_repository.get_icon(id)
      unless icon.nil?
        icon.save(path)
      end
    end

    def export_image(id, path)
      image = @platform_repository.get_image(id)
      unless image.nil?
        image.save(path)
      end
    end

    def get_cores
      @core_repository.get_cores
    end

    def get_data(id)
      @core_repository.get_data(id)
    end

    def get_platform(id)
      @platform_repository.get_platform(id)
    end
  end
end
