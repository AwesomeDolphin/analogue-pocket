require 'octokit'

module Updater
  class GitHubService
    attr_reader :client

    def initialize
      @client = Octokit::Client.new(:netrc => true)
    end

    def contents(repository, options = {})
      @client.contents(repository, options)
    end

    def latest_release(repository, prerelease = false)
      releases = @client.releases(repository)
      releases.find { |release| release.prerelease == prerelease }
    end

    def release_assets(release_url)
      @client.release_assets(release_url)
    end
  end
end
