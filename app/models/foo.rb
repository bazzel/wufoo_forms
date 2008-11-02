class Foo < ActiveRecord::Base
  30.times {|i| validates_presence_of "req_field_#{i}"}
end
