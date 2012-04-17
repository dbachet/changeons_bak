class CreateModerationSettings < ActiveRecord::Migration
  def up
    create_table :moderation_settings do |t|
        t.boolean :published
        t.boolean :moderated
        t.string :refuse_cause
        t.references :moderatable, :polymorphic => true
        t.timestamps
    end
  end

  def down
    drop_table :moderation_settings
  end
end