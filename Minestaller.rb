#Minestaller | Version 1 | Written by: Mark Roberts | License: Odds are it will be BSD
#About: Minestaller is to be able to quickly create and update a Minecraft Bedrock server on Linux.

require 'thor'

class Minestaller < Thor
  map %w[--version -v] => :PrintTheVersion
  desc "--version -v", "Print the version of Minestaller."
  def PrintTheVersion
    puts "0.1-alpha-dev"
  end
end

Minestaller.start(ARGV)
