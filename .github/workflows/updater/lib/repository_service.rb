require 'open-uri'
require 'tempfile'
require 'zip'

require_relative 'updater/data_repository'
require_relative 'github/github_service'

module Updater
  class RepositoryService
    attr_reader :data_repository, :github_service

    def initialize
      @data_repository = DataRepository.new
      @github_service = GitHub::GitHubService.new
    end

    def get_repositories
      @data_repository.get_repositories
    end

    def download(repository)
      download_url = get_download_url(repository)

      # create a temp file
      temp_file = Tempfile.new([repository.display_name, 'zip'], :binmode => true)

      begin
        # download the file
        URI.open(download_url, 'rb') do |asset|
          temp_file.write(asset.read)
        end

        # extract the archive to a temp folder
        temp_dir = Dir.mktmpdir(repository.display_name)
        Zip::File.open(temp_file.path) do |zip|
          zip.each do |file|
            file_path = File.join(temp_dir, file.name)
            FileUtils.mkdir_p(File.dirname(file_path))
            zip.extract(file, file_path) unless File.exist?(file_path)
          end
        end

        temp_dir
      ensure
        # delete the temp file
        temp_file.unlink unless temp_file.nil?
      end
    end

    private

    def get_download_url(repository)
      if repository.path.nil?
        release = @github_service.latest_release(repository)
        assets = @github_service.release_assets(release.url)
        asset = repository.filter.nil? ? assets.first : assets.find { |asset| asset.name.match?(Regexp.new(repository.filter)) }
        asset.browser_download_url
      else
        resources = @github_service.contents(repository, { :path => repository.path })
        resource = repository.filter.nil? ? resources : resources.find { |content| content.name.match?(Regexp.new(repository.filter)) }
        resource.download_url
      end
    end
  end
end
