require_relative 'content_repository'
require_relative 'release_repository'

module Updater
  class RepositoryFactory
    def self.create(type, display_name, options={})
      case type
      when :content
        ContentRepository.new(display_name, options)
      when :release
        ReleaseRepository.new(display_name, options)
      else
        raise TypeError.new("no implicit conversion of #{type} into Repository")
      end
    end
  end
end
