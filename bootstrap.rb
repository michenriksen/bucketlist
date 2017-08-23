require "rubygems"
require "sequel"
require "pg"
require "httparty"
require "thread/pool"
require "ox"
require "cgi"
require "logger"
require "timeout"
require "sinatra"
require "colorize"
require "yaml"
require "optparse"

CONFIG_FILE_PATH = File.join(File.dirname(__FILE__), "config.yml").freeze

if !File.exists?(CONFIG_FILE_PATH)
  puts "Error: Configuration file has not been created!\n".red
  puts "Copy " + "config.yml.example".bold + " to " + "config.yml".bold + " and change configuration to work with your setup."
  exit 1
end

CONFIG = YAML.load_file(CONFIG_FILE_PATH)

DB = Sequel.connect("postgres://#{CONFIG['db_username']}:#{CONFIG['db_password']}@#{CONFIG['db_host']}:#{CONFIG['db_port']}/#{CONFIG['db']}", :max_connections => 25)
Sequel.extension :migration
Sequel::Model.db.extension(:pagination)
Sequel::Model.plugin :timestamps
Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), "db", "migrations"), :use_transactions => true)

require_relative "db/models/bucket"
require_relative "db/models/bucket_object"
