require_relative 'github_repository'

module Updater
  class ContentRepository < GitHubRepository
    attr_reader :path, :filter

    def download_url
      @download_url ||= asset_url
    end

    def initialize(display_name, options = {})
      super(display_name, options)

      @path = options[:path]
      @filter = options[:filter]
    end

    private

    def asset_url
      resources = @github_service.contents(@repository, :path => @path)
      resource = filter.nil? ? resources : resources.find { |content| content.name.match?(Regexp.new(filter)) }
      resource.download_url
    end
  end
end
