class Foo < ActiveRecord::Base
  30.times {|i| validates_presence_of "req_field_#{i}"}

  has_many :bars

  validates_associated    :bars, :on => :update  

  def new_bar_attributes=(bar_attributes)
    bar_attributes.each do |attributes|
      bars.build attributes
    end
  end

  def existing_bar_attributes=(bar_attributes)
    bars.reject(&:new_record?).each do |bar|
      attributes = bar_attributes[bar.id.to_s]
      if attributes
        bar.attributes = attributes
      else
        bars.delete bar
      end
    end
  end

end
