require_relative 'github_repository'

module Updater
  class ReleaseRepository < GitHubRepository
    attr_reader :prerelease, :filter

    def download_url
      @download_url ||= asset_url
    end

    def initialize(display_name, options = {})
      super(display_name, options)

      @prerelease = options[:prerelease] || false
      @filter = options[:filter]
    end

    private

    def asset_url
      release = @github_service.latest_release(@repository, @prerelease)
      assets = @github_service.release_assets(release.url)
      asset = filter.nil? ? assets.first : assets.find { |asset| asset.name.match?(Regexp.new(filter)) }
      asset.browser_download_url
    end
  end
end
