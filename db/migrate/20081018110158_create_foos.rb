class CreateFoos < ActiveRecord::Migration
  def self.up
    create_table :foos do |t|
      30.times {|i| t.string "field_#{i}"}
      30.times {|i| t.string "req_field_#{i}"}
      #   
      #   
      # t.string :field_title
      # t.string :small_field
      # t.string :medium_field
      # t.string :large_field
      # t.string :multiple_choice
      # t.string :checkboxes
      t.timestamps
    end
  end
  
  def self.down
    drop_table :foo
  end
end
