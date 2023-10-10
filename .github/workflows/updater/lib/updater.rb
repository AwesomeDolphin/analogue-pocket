require_relative 'repository_service'

module Updater
  class << self
    def test_repository
      repository_service = RepositoryService.new
      repositories = repository_service.get_repositories
      repositories.each do |repository|
        puts "Downloading #{repository.display_name}"
        repository_service.download(repository)
      end
    end
  end
end

if __FILE__ == $0
  Updater.test_repository
end
