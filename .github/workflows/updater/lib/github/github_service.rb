require 'base64'
require 'octokit'

require_relative 'funding'

module GitHub
  class GitHubService
    GITHUB_DIRECTORY = '.github'
    FUNDING_FILE = 'FUNDING.yml'

    attr_reader :client

    def initialize
      @client = Octokit::Client.new(:netrc => true)
    end

    def contents(repository, options = {})
      @client.contents(Octokit::Repository.new({ :owner => repository.owner, :name => repository.name }), options)
    end

    def funding(repository)
      begin
        path = File.join(GITHUB_DIRECTORY, FUNDING_FILE)
        content = file_content(repository, { :path => path })
        Funding.parse_content(content)
      rescue Octokit::NotFound
        # Failed to find FUNDING.yml
        return nil
      end
    end

    def latest_release(repository)
      releases = @client.releases(Octokit::Repository.new({ :owner => repository.owner, :name => repository.name }))
      releases.find { |release| release.prerelease == repository.prerelease }
    end

    def release_assets(release_url)
      @client.release_assets(release_url)
    end

    private

    def file_content(repository, options = {})
      resource = contents(repository, options)
      return Base64.decode64(resource.content)
    end
  end
end
