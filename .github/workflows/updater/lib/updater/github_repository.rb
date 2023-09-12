require 'octokit'

require_relative 'github_service'
require_relative 'repository'

module Updater
  class GitHubRepository < Repository
    attr_reader :github_service, :repository, :download_url

    def initialize(display_name, options = {})
      super(display_name)

      @github_service = GitHubService.new

      owner = options[:owner]
      name = options[:name]
      @repository = Octokit::Repository.new({:owner => owner, :name => name})
    end
  end
end
