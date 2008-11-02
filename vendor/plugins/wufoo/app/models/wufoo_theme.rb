class WufooTheme < ActiveRecord::Base
  validates_uniqueness_of :theme
  validates_presence_of :theme
  validates_presence_of :css
end
