module Analogue
  class FileRepository
    attr_reader :root_path

    def initialize(root_path)
      @root_path = root_path
    end

    def read_file(relative_path)
      path = File.join(@root_path, relative_path)
      File.read(path)
    end

    def parse_json(relative_path)
      json = read_file(relative_path)
      JSON.parse(json, { object_class: OpenStruct })
    end
  end
end
