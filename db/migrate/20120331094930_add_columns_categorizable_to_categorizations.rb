class AddColumnsCategorizableToCategorizations < ActiveRecord::Migration
  def self.up
    change_table :categorizations do |t|
      t.references :categorizable, :polymorphic => true
    end
  end

  def self.down
    change_table :categorizations do |t|
      t.remove_references :categorizable, :polymorphic => true
    end
  end
end
