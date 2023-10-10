module Updater
  class Repository
    attr_reader :display_name, :owner, :name, :prerelease, :path, :filter

    def initialize(display_name, owner, name, options = {})
      @display_name = display_name
      @owner = owner
      @name = name

      @prerelease = options[:prerelease] || false
      @path = options[:path]
      @filter = options[:filter]
    end
  end
end
