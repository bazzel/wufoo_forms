module SilkspriteHelper
  
  def silksprite(sprite, options = {})
    options[:class] = 'ss_sprite '
    options[:class] << "ss_#{sprite}"
    content_tag(:span, '&nbsp;', options)
  end
  
  def ss_span(sprite, options = {})
    options[:class] = 'ss_sprite '
    options[:class] << "ss_#{sprite}"
    content_tag(:span, '&nbsp;', options)
  end

  def ss_div(sprite, options = {})
    options[:class] = 'ss_sprite '
    options[:class] << "ss_#{sprite}"
    content_tag(:div, '&nbsp;', options)
  end
  
  def ss_link_to(name, options = {}, html_options = nil) 
    sprite = html_options.delete(:sprite)
    html_options[:class] = 'ss_sprite '
    html_options[:class] << "ss_#{sprite}"
    link_to(name, options, html_options) 
  end

end