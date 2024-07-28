#Minestaller | Version 1 | Written by: Mark Roberts | License: Odds are it will be BSD
#About: Minestaller is to be able to quickly create and update a Minecraft Bedrock server on Linux.

require 'thor'
require 'down'
require 'fileutils'
require 'zip'

class Minestaller < Thor
  no_commands do
    def test
     puts "Test"
    end
    
    def extract_zip(file, destination)
       FileUtils.mkdir(destination)
       Zip::File.open(file) do |zip_file|
         zip_file.each do |f|
           fpath = File.join(destination, f.name)
           zip_file.extract(f, fpath) unless File.exist?(fpath)
    end
       end
    end
  end
  map %w[--version -v] => :PrintTheVersion
  desc "--version -v", "Print the version of Minestaller."
  def PrintTheVersion
    puts "0.1-alpha-dev"
  end

  map %w[--install -i] => :Install
  desc "--install -i", "Perform fresh install of Bedrock Server"
  method_option :url, :type => :string, :required => true
  #method_option :path, :type => :string, :required => true
  #method_option :worldname, :type => :string, :required => true
  def Install
    suppliedURL = options[:url]
    puts "Supplied URL: #{suppliedURL}"
    fileName = suppliedURL[/bed.+/]
    puts "Filename: #{fileName}"
    currentPath = Dir.pwd
    puts "Current Path: #{currentPath}"
    downloadDirectory = currentPath + "/Downloads"
    puts "Download Path: #{downloadDirectory}"

    tempfile = Down.download("#{suppliedURL}")
    FileUtils.mv(tempfile.path, "./Downloads/#{tempfile.original_filename}")
    FileUtils.chmod 0755, "./Downloads/#{tempfile.original_filename}"
    
    worldName = "hello2-world"
    downloadedFilePath = "./Downloads/#{tempfile.original_filename}"
    extractionLocation = "./Installs/#{worldName}"    

    extract_zip(downloadedFilePath,extractionLocation)
    
    test
  end
end

Minestaller.start(ARGV)
