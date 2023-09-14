require 'json'
require 'ostruct'
require_relative 'analogue/openfpga_service'
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
      openfpga_service = Analogue::OpenFPGAService.new(root_path)

      cores = openfpga_service.get_cores
      cores.inspect

      cores.each do |core|
        data = openfpga_service.get_data(core.id)
        data.inspect

        platform_id = core.platform_id
        platform = openfpga_service.get_platform(platform_id)
        platform.inspect
      end
    end
  end
end

if __FILE__ == $0
  Updater.test_release
end
