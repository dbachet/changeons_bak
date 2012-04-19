class CreateTableAvatar < ActiveRecord::Migration
  def up
    create_table :avatars do |t|
      t.has_attached_file :avatar

      t.timestamps
    end
  end

  def down
    drop_table :avatars
  end
end
