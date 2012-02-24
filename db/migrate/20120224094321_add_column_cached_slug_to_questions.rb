class AddColumnCachedSlugToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :cached_slug, :string
  end

  def self.down
    remove_column :questions, :cached_slug
  end
end
