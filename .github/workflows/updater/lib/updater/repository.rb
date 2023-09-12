require 'open-uri'
require 'tempfile'
require 'tmpdir'
require 'zip'

module Updater
  class Repository
    attr_reader :display_name

    def download_url
      raise NotImplementedError.new("#{self.class} has not implemented method '#{__method__}'")
    end

    def initialize(display_name)
      @display_name = display_name
    end

    def download
      # create a temp file
      temp_file = Tempfile.new([@display_name, 'zip'], :binmode => true)

      begin
        # download the file
        URI.open(download_url, 'rb') do |asset|
          temp_file.write(asset.read)
        end

        # extract the archive to a temp folder
        temp_dir = Dir.mktmpdir(@display_name)
        Zip::File.open(temp_file.path) do |zip|
          zip.each do |file|
            file_path = File.join(temp_dir, file.name)
            FileUtils.mkdir_p(File.dirname(file_path))
            zip.extract(file, file_path) unless File.exist?(file_path)
          end
        end

        temp_dir
      ensure
        # delete the temp file
        temp_file.unlink unless temp_file.nil?
      end
    end
  end
end
