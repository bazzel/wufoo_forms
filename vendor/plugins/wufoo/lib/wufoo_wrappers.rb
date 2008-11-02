# This module contains wrappers for helper methods defined
# in WufooHelper so they can be used within a form_for block.
module WufooWrappers
  
  # Wrapper for WufooHelper::section.
  def section(title, description = '', first = false)
    @template.section(title, description, first)
  end

  # Wrapper for WufooHelper::check_box_tag.
  def check_box_tag(name, value = "1", checked = false, options = {})
    @template.check_box_tag(name, value, checked, options)
  end

end