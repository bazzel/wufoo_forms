class Bar < ActiveRecord::Base
  3.times {|i| validates_presence_of "req_field_#{i}"}
  
  belongs_to :foo
end
