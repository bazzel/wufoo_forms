class CreateWufooThemes < ActiveRecord::Migration
  def self.up
    create_table :wufoo_themes do |t|
      t.string :theme
      t.string :css

      t.timestamps
    end
  end

  def self.down
    drop_table :wufoo_themes
  end
end
