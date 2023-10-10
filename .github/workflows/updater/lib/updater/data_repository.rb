require 'yaml'

require_relative 'repository'

module Updater
  class DataRepository
    DATA_DIRECTORY = '_data'
    REPOSITORIES_FILE = 'repositories.yml'

    def get_repositories
      path = File.join(DATA_DIRECTORY, REPOSITORIES_FILE)
      yaml = YAML.load_file(path)
      yaml.map do |entry|
        owner = entry['username']
        cores = entry['cores']
        cores.map do |core|
          display_name = core['display_name']
          repository = core['repository']

          prerelease = core['prerelease'] || false
          path = core['path']
          filter = core['filter']

          options = { :prerelease => prerelease, :path => path, :filter => filter }

          Repository.new(display_name, owner, repository, options)
        end
      end.flatten
    end
  end
end
