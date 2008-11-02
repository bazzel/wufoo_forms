# This module contains wrappers 3rd party plugin view helpers.
#
# Supported helper methods:
#  file_column_field (plugin FileColumn)
#  related_collection_select (RelatedSelectFor)
#  text_field_with_auto_complete (Autocomplete)
module PluginWrappers

  # Wufoo variaton for FileColumn view helper file_column_field.
  def file_column_field(object, method, options={})
    options[:class] = "field file "
    build_shell(method, options) do
      @template.file_column_field(object, method, options={})
    end
  end

  # Autocomplete plugin required!
  def text_field_with_auto_complete(object, method, tag_options = {}, completion_options = {})
    tag_options[:class] = "field text "
    tag_options[:class] << (tag_options.delete(:length) || "medium")
    build_shell(method, tag_options) do
      @template.text_field_with_auto_complete(object, method, tag_options, completion_options)
    end
    
  end
  
  # RelatedSelectFor plugin required!
  # http://retro.dvisionfactory.com/related-select-forms
  def related_collection_select(object, method, parent_element, collection, value_method, text_method, reference_method, options = {}, html_options = {})
    html_options[:class] = "field select "
    html_options[:class] << (html_options.delete(:length) || "medium")
    build_shell(method, html_options) do
      @template.content_tag(:div, 
                            @template.related_collection_select(object, 
                                                                method, 
                                                                parent_element, 
                                                                collection, 
                                                                value_method, 
                                                                text_method, 
                                                                reference_method, 
                                                                options, 
                                                                html_options)
                                      )
    end
  end

  # CalendarDateSelect plugin required!
  # git://github.com/timcharper/calendar_date_select.git
  def calendar_date_select(method, options={})
    options[:class] = "field text icon "
    options[:class] << (options.delete(:length) || "medium")
    build_shell(method, options) do
      super
    end
  end

end