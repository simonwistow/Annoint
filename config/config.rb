require 'rubygems' if RUBY_VERSION < "1.9"
require 'bundler/setup'

require 'all_your_base/are/belong_to_us'
require 'data_mapper'
require 'dm-core'
require 'dm-timestamps'
require 'dm-types'
require 'dm-serializer'
require 'erb'
require 'find'
require 'json'
require 'logger'
require 'mail'
require 'pp'
require 'sinatra'
require 'uuidtools'

module Annoint
  ROOT      = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  ENV_NAME  = ENV['ANNOINT_ENV'] || 'development'
  LOGGER    = Logger.new(STDERR)
  
  # Load vendored libraries
  $: << File.join(ROOT, 'vendor', 'lib')
    
  def self.setup
    $: << File.join(ROOT, 'lib')
    LOGGER.level = ENV_NAME == 'development' ? Logger::DEBUG : Logger::INFO
    
    DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/annoint.db")

    require 'application'
  end
  
  def self.create_index
    index = {}
    Dir.foreach(File.join(ROOT, 'public', 'issues')) do |year|
      next unless year.match(/^\d{4}$/)
      Dir.foreach(File.join(ROOT, 'public', 'issues', year)) do |file|
          next unless file.match(/^now(\d{2})(\d{2})\.title$/)
          month = $1
          day   = $2
          File.open(File.join(ROOT, 'public', 'issues', year, file), "rb") do |f|
            title = f.readline.chomp
            blurb = f.readline.chomp
            index["#{year}/#{month}/#{day}"] = { :title => title, :blurb => blurb}
          end
      end
    end
    index
  end
  
  CONFIG = YAML.load_file(File.join(ROOT, 'config', 'config.yml'))[ENV_NAME]
  INDEX  = Annoint.create_index
end

Annoint.setup