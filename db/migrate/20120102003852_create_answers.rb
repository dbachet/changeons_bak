# -*- encoding : utf-8 -*-
class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.string :content
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
