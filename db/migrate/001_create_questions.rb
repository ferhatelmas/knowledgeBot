# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), '../..', 'config/environment.rb')

class Questions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :question_hash
      t.string :question_text
      t.integer :correct
      t.text :choices
    end

    add_index :questions, :question_hash
  end

  def self.down
    drop_table :questions
  end
end
