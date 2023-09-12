module Analogue
  class Metadata
    attr_reader :platform_ids, :shortname, :description, :author, :version, :date_release

    def initialize(metadata)
      @platform_ids = metadata.platform_ids
      @shortname = metadata.shortname
      @description = metadata.description
      @author = metadata.author
      @version = metadata.version
      @date_release = metadata.date_release
    end
  end
end
