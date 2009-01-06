class CreateBars < ActiveRecord::Migration
  def self.up
    create_table :bars do |t|
      3.times {|i| t.string "field_#{i}"}
      3.times {|i| t.string "req_field_#{i}"}
      
      t.references :foo
      
      t.timestamps
    end
  end

  def self.down
    drop_table :bars
  end
end
