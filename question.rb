# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), 'config/environment.rb')

class Question < ActiveRecord::Base
  serialize :choices
end
