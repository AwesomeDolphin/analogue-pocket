require 'json'
require 'ostruct'
require_relative 'analogue/core_repository'
require_relative 'analogue/platform_repository'
require_relative 'updater/repository_factory'

module Updater
  class << self
    def test_content
      display_name = 'Contra'
      options = {:owner => 'jotego', :name => 'jtbin', :path => 'pocket/zips/jotego.jtcontra.zip'}

      repository = Updater::RepositoryFactory.create(:content, display_name, options)
      root_path = repository.download

      enumerate_cores(root_path)
    end

    def test_release
      display_name = 'Spiritualized GB'
      options = {:owner => 'spiritualized1997', :name => 'openFPGA-GB-GBC', :filter => 'Spiritualized_GB_'}

      repository = Updater::RepositoryFactory.create(:release, display_name, options)
      root_path = repository.download

      enumerate_cores(root_path)
    end

    def enumerate_cores(root_path)
      core_repository = Analogue::CoreRepository.new(root_path);
      platform_repository = Analogue::PlatformRepository.new(root_path);

      cores = core_repository.get_cores
      cores.inspect

      cores.each do |core|
        data = core_repository.get_data(core.id)

        platform_id = core.platform_id
        platform = platform_repository.get_platform(platform_id)
        platform.inspect
      end
    end
  end
end

if __FILE__ == $0
  Updater.test_release
end
