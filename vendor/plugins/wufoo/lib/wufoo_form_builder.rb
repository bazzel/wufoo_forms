#---
# Excerpted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
#---
class WufooFormBuilder < ActionView::Helpers::FormBuilder

 include WufooWrappers
 include PluginWrappers
 
  @@partial = 'field'
  @@err_partial = 'field_with_errors'
  @@errs_partial = 'error_messages'

  helpers = field_helpers +
            %w(date_select datetime_select time_select) +
            %w(select country_select time_zone_select) -
            %w(label fields_for) -
            %w(text_field text_area radio_button submit file_field check_box select country_select)


  # Returns an input tag of the "text" type.
  #
  # ==== Options
  # * <tt>:label</tt>: Replaces the attribute name as a label in front of the textbox.
  # * <tt>:length</tt>: Size of the textbox, can be 'small', 'medium', 'large' or 'full'. Defaulted to: 'medium'.
  # * <tt>:position</tt>: Position of the textbox, used when 2 input boxes must be placed on one line, can be: 'left' or 'right'.
  # * <tt>:balloon</tt>: Shown as tooltip when mouse is hovered over the textbox. When used with <tt>position</tt>, the balloon is shown below the textbox.
  # * <tt>:caption</tt>: Shown as small text below the textbox.
  #
  # ==== Examples
  #  text_field :name
  #  # => <li>
  #        <label for="foo_name" class="desc">Name</label>
  #        <div>
  #         <input type="text" size="30" name="foo[name]" id="foo_name" class="field text medium"/>
  #        </div>
  #       </li>
  #
  #  text_field :name, :length => 'large'
  #
  #  text_field :first_name, :position => 'left'
  #  text_field :last_name, :position => 'right'
  def text_field(method, options = {})
    options[:class] = "field text "

    if @box
      prefix = options[:prefix] ? " #{options[:prefix]} " : ""
      suffix = options[:suffix] ? " #{options[:suffix]} " : ""
      label = label(method, label_text_only(method, options.delete(:label)))
      @template.content_tag(:span, prefix + super + suffix + label)
    elsif @canvas
      options[:class] << 'addr'
      span_options = {}
      span_options[:class] = options.delete(:length) || options.delete(:position) || 'full'
      label = label(method, label_text_only(method, options.delete(:label)))
      @template.content_tag(:span, super + label, span_options)
    else
      options[:class] << (options.delete(:length) || "medium")
      build_shell(method, options) { super }
    end
  end

  # Returns a textarea...
  #
  # ==== Examples
  #  text_area :bar, 
  #            :label => 'Field Title',
  #            :balloon => "Instructions for the user."
  #  # => <li>
  #        <label for="foo_bar" class="desc">Field Title<span class="req"> *</span></label>
  #        <div>
  #         <textarea rows="20" name="foo[bar]" id="foo_bar" cols="40" class="field textarea medium"/>
  #        </div>
  #        <p class="instruct">Instructions for the user...</p>
  #       </li>
  def text_area(method, options = {})
    options[:class] = "field textarea "
    options[:class] << (options.delete(:length) || "medium")
    build_shell(method, options) { super }
  end

  # Returns a radio button tag.
  # ==== Options
  # * <tt>:label</tt>: Replaces the attribute name as a label after the radio button.
  def radio_button(method, tag_value, options = {})
    id = ["#{object.class}".underscore, method, tag_value].join('_')
    label_text = options.delete(:label) || method.to_s.humanize
    label = label(method, label_text, :class => 'choice', :for => id)
    options[:class] = "field radio "
    options[:id] = id
    super(method, tag_value, options) + label
  end
  
  def file_field(method, options = {})
    options[:class] = "field file "
    options[:class] << (options.delete(:length) || "medium")
    build_shell(method, options) { super }
  end
  
  # Create a select tag and a series of contained option tags for the provided object and method.
  #
  # ==== Options
  # * <tt>:label</tt>: Replaces the attribute name as a label in front of the textbox.
  # * <tt>:length</tt>: Size of the textbox, can be 'small', 'medium', 'large' or 'full'. Defaulted to: 'medium'.
  # * <tt>:position</tt>: Position of the textbox, used when 2 inout boxes must be placed on one line, can be: 'left' or 'right'.
  # * <tt>:balloon</tt>: Shown as tooltip when mouse is hovered over the textbox. When used with <tt>position</tt>, the balloon is shown below the textbox.
  # * <tt>:caption</tt>: Shown as small text below the textbox.
  #
  # ==== Examples
  #  select :bar, ['Invisibility', 'Super Strength', 'Eye Lasers']
  def select(method, choices, options = {}, html_options = {})
    html_options[:class] = "field select "
    html_options[:class] << (html_options.delete(:length) || "medium")
    build_shell(method, html_options) { super }
  end
  
  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    html_options[:class] = "field select "
    html_options[:class] << (html_options.delete(:length) || "medium")
    build_shell(method, html_options) { super }
  end
  
  def country_select(method, priority_countries = nil, options = {}, html_options = {}) 
    html_options[:class] = "field select "

    if @canvas
      html_options[:class] << 'addr'
      span_options = {}
      span_options[:class] = html_options.delete(:length) || html_options.delete(:position) || 'full'
      label = label(method, label_text_only(method, html_options.delete(:label)))
      @template.content_tag(:span, super + label, span_options)
    else
      html_options[:class] << (html_options.delete(:length) || "medium")
      build_shell(method, html_options) { super }
    end
  end
  
  # options[:cancel] = {:title => 'Annuleren', :url => root_path }
  #
  # Output modified to fit ParticleTree's buttons (http://particletree.com/features/rediscovering-the-button-element/).
  # Images replaced by SilkSprite (http://www.ajaxbestiary.com/Labs/SilkSprite/) (silkpsrite plugin required)
  def submit(value = "Submit", options = {})
    tick = @template.silksprite(:tick)
    button = @template.content_tag(:button, "#{tick} #{value}", :class => 'button positive', :type => 'submit')
    
    if (cancel = options[:cancel])
      cross = @template.silksprite(:cross)
      button << @template.link_to("#{cross} #{cancel[:title]}", cancel[:url], :class => 'button negative')
    end
    @template.content_tag(:li, button, :class => 'buttons')
  end
  
  # Custom
  
  # Wrapper for group of radio buttons or checkboxes dor <tt>method</tt>.
  #
  # ==== Options
  # * <tt>:label</tt>: Replaces the attribute name as a label in front of the textbox.
  # * <tt>:balloon</tt>: Shown as tooltip when mouse is hovered over the textbox. When used with <tt>position</tt>, the balloon is shown below the textbox.
  # * <tt>:caption</tt>: Shown as small text below the textbox.
  #
  # ==== Examples
  #  <% radio_button_group :bar do %>
  #   <p>Description</p>
  #  <% end %>
  #  => <li class="">
  #      <label class="desc">Bar</label>
  #      <div class='column'>
  #       Description
  #      </div>
  #     </li>             
  def radio_button_group(method, options = {}, &block)
    instruct = tooltip(options)
    content = @template.content_tag(:div, @template.capture(&block), :class => 'column')
    content << instruct if instruct
    label = @template.content_tag(:label, label_text(method, options.delete(:label)), :class => 'desc')

    if object.errors.on(method)
      content << @template.content_tag(:p, error_message(method, options), :class => 'error')
      options[:class] = 'error'  
    end

    li = @template.content_tag(:li, label + content, options)
    @template.concat li, block.binding
  end

  alias :check_box_group :radio_button_group
  
  def box(method, options = {}, &block)
    @box = true
    
    instruct = tooltip(options)
    label = @template.content_tag(:label, label_text(method, options.delete(:label)), :class => 'desc')
    content = label + @template.capture(&block)
    content << instruct if instruct

    if object.errors.on(method)
      content << @template.content_tag(:p, error_message(method, options), :class => 'error')
      options[:class] = "#{li_class(options)} error"  
    else
      options[:class] = li_class(options)
    end
    
    @box = false
    # options[:class] = li_class(options)
    @template.concat @template.content_tag(:li, content, options), block.binding
  end

  def canvas(method, options = {}, &block)
    @canvas = true
    content = radio_button_group(method, options, &block)
    @canvas = false
    return content
  end

  def error_messages
    @template.render(:file => "#{Wufoo::PLUGIN_VIEWS_PATH}/#{@@errs_partial}.html.erb", 
                     :use_full_path => false) unless object.errors.empty?

  end

  helpers.each do |name|
    define_method name do |field, *args|
      options = args.detect {|argument| argument.is_a?(Hash)} || {}
      build_shell(field, options) do
        super
      end
    end
  end

  private 
  def build_shell(field, options)
    instruct = tooltip(options)
    element = @template.content_tag(:div, yield) + instruct
    
    lc = li_class options
    
    @template.capture do
      label = label(field, label_text(field, options.delete(:label)), :class => 'desc')
      locals = {
        :element => element,
        :label   => label,
        :li_class => lc
      }
      if has_errors_on?(field)
        locals.merge!(:error => error_message(field, options))
        @template.render :file => "#{Wufoo::PLUGIN_VIEWS_PATH}/#{@@err_partial}.html.erb", 
                         :locals  => locals, 
                         :use_full_path => false
      else
        @template.render :file => "#{Wufoo::PLUGIN_VIEWS_PATH}/#{@@partial}.html.erb", 
                         :locals  => locals, 
                         :use_full_path => false
      end
    end
  end

  def error_message(field, options)
    errors = object.errors.on(field)
    errors.is_a?(Array) ? errors.to_sentence : errors
  end

  def has_errors_on?(field)
    !(object.nil? || object.errors.on(field).blank?)
  end

  def label_text_only(field, text = nil) 
    text || field.to_s.humanize
  end 

  def label_text(field, text = nil) 
    "#{label_text_only(field, text)}#{required_mark(field)}" 
  end 

  def required_mark(field)
    required_field?(field) ? @template.content_tag( :span, ' *', :class => 'req') : '' 
  end 

  def required_field?(field) 
    @object.class.to_s.constantize. 
                      reflect_on_validations_for(field). 
                      map(&:macro).include?(:validates_presence_of) 
  end

  def tooltip(options)
    if (instruct = options.delete(:balloon))
      @template.content_tag(:p, instruct, :class => 'instruct')
    elsif (instruct = options[:caption])
      @template.content_tag(:p, @template.content_tag(:small, instruct), :class => 'instruct')
    else
      ""
    end
  end

  def li_class(options = {})
    class_name = "#{options.delete(:position)}Half" unless options[:position].blank?
    class_name = "altInstruct" unless options.delete(:caption).blank?
    class_name
  end

  def logger
    RAILS_DEFAULT_LOGGER
  end

end

# Override validation error display:
# See http://wiki.rubyonrails.org/rails/pages/HowtoChangeValidationErrorDisplay.
ActionView::Base.field_error_proc = Proc.new{|html_tag, instance| html_tag }
