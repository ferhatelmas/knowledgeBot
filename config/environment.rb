# -*- encoding : utf-8 -*-
require 'rubygems'
require 'active_record'
require 'yaml'

# dirty fix for parser error
# http://stackoverflow.com/questions/4980877/rails-error-couldnt-parse-yaml
YAML::ENGINE.yamler = 'syck'

dbconfig = YAML::load(File.open(File.join(File.dirname(__FILE__), 'real_database.yml')))
ActiveRecord::Base.establish_connection(dbconfig)

webconfig = YAML::load(File.open(File.join(File.dirname(__FILE__), 'real_site_credentials.yml')))
USERNAME = webconfig["username"]
PASSWORD = webconfig["password"]
