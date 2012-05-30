require 'rubygems' if RUBY_VERSION < "1.9"
require 'bundler/setup'

require 'all_your_base/are/belong_to_us'
require 'data_mapper'
require 'dm-core'
require 'dm-timestamps'
require 'dm-types'
require 'erb'
require 'json'
require 'logger'
require 'mail'
require 'pp'
require 'sinatra'
require 'uuidtools'

module Annoint
  ROOT      = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  ENV_NAME  = ENV['Annoint_ENV'] || 'development'
  LOGGER    = Logger.new(STDERR)
  
  # Load vendored libraries
  $: << File.join(ROOT, 'vendor', 'lib')
  
  CONFIG = YAML.load_file(File.join(ROOT, 'config', 'config.yml'))[ENV_NAME]
  
  def self.setup
    $: << File.join(ROOT, 'lib')
    LOGGER.level = ENV_NAME == 'development' ? Logger::DEBUG : Logger::INFO
    
    DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/annoint.db")
    
    require 'application'
  end
  
end

Annoint.setup