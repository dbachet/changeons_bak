class CreateQuestionCategorization < ActiveRecord::Migration
  def self.up
    create_table :question_categorizations do |t|
      t.integer :question_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :question_categorizations
  end
end
