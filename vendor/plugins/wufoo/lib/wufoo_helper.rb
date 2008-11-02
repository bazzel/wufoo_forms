module WufooHelper

  # Plaats block in een HTML LI tag met classnamae 'buttons':
  # <% buttons do %>
  #   Asjemenou
  # <% end %>
  #
  # <li class='buttons'>Asjemenou</li>
  def buttons(&block)
    concat content_tag(:li, capture(&block), :class => 'buttons'), block.binding
  end

  # Surrounds <tt>title</tt> and an optional <tt>description</tt> 
  # with HTML tags:
  # <%= form_title 'Title', 'Description' %>
  #
  # <div class="info">
  #  <h2>Title</h2>
  #  <div>Description</div>
  # </div>
  def form_title(title, description = '')
    content = content_tag(:h2, title)
    content << content_tag(:div, description) unless description.blank?
    content_tag(:div, content, :class => 'info')
  end

  # Surronds <tt>title</tt> and an optional <<tt>description</tt>
  # with HTML tags and presents it as a section title.
  # Use true as <tt>first</tt> if the section comes
  # immediately after the form_title. 
  def section(title, description = '', first = false)
    class_name = "section"
    class_name << " first" if first
    content = content_tag(:h3, title)
    content << content_tag(:div, description) unless description.blank?
    content_tag(:li, 
                content, 
                :class => class_name)
  end

  # Creates a check box form input tag.
  #
  # ==== Options
  # * <tt>:label</tt>: Replaces the attribute name as a label in front of the textbox.
  #
  # ==== Examples
  #  check_box_tag("parent[child_ids][]", 5, false, :label => 'Eye Lasers')
  #  => <input type="checkbox" value="Eye Lasers" name="parent[child_ids][]" label="Eye Lasers" id="parent_child_ids_5" class="field checkbox"/>
  #     <label for="parent_child_ids_5" class="choice">Eye Lasers</label>
  def check_box_tag(name, value = "1", checked = false, options = {})
    id = "#{name}#{value}".gsub(/\[\]/,'').gsub(/[\[\]\ ]/, '_').downcase
    label = options[:label] ? label_tag(id, options.delete(:label), :class => 'choice') : ""
    options[:class] = 'field checkbox'
    options[:id] = id
    super + label
  end


  # options :html => {:alignment  => 'left|right',
  #                   :title      => '...' }
  def wufoo_form_for(record_or_name_or_array, *args, &proc) 
    options = args.detect { |argument| argument.is_a?(Hash) } 
    if options.nil? 
      options = {:builder => WufooFormBuilder} 
      args << options 
    end 
    options[:builder] = WufooFormBuilder unless options.nil? 

    options[:html] ||= {}
    class_name = 'wufoo'

    if (alignment = options[:html].delete(:alignment))
      class_name << " #{alignment}Label"
    end
    
    title = get_title(options[:html].delete(:title))
    
    options[:html][:class] = class_name
    
    # head
    concat(top, proc.binding)
    concat("<div id='container'>", proc.binding)
    concat(title, proc.binding) if title
    form_for(record_or_name_or_array, *args, &proc)
    # form_for(record_or_name_or_array, *args) do |f|
    #   proc.call
    # end

    concat("</div>", proc.binding)
    concat(bottom, proc.binding)
  end
  
  # Retourneert een link voor het uitbreiden
  # van een subform met een partial voor object.
  # >> add_sub_link "Categorie toevoegen", 
  #                 :categories, 
  #                 :object => Category, :partial => 'category'
  def add_sub_link(name, id, options) 
    content_tag :li, :class => 'buttons' do
      link_to_function "#{image_tag('icons/add.png')} #{name}", :class => 'positive' do |page| 
          page.insert_html :bottom, 
                         id, 
                         :partial => options[:partial], 
                         :object => options[:object].new 
      end 
    end
  end 

  def wufoo_stylesheet(object_or_id = nil)
    theme = theme_for(object_or_id) || 'theme'
    
    stylesheet 'structure', 'form', theme, 'buttons'
    javascript 'wufoo'
  end

  private
  # <img id="top" src="/images/top.png" alt=""/>
  def top
    image_tag('top.png', :id => 'top', :alt => '')
  end
  
  # <img id="bottom" src="/images/bottom.png" alt=""/>
  def bottom
    image_tag('bottom.png', :id => 'bottom', :alt => '')
  end
    
  # Plaats html LINK tag naar javascript en stylesheets
  # files in HEAD.
  def head
    stylesheet 'structure', 'form', 'theme', 'buttons'
    javascript 'wufoo'
  end
  
  def theme_for(object_or_id = nil)
    return nil unless object_or_id
    
    if object_or_id.is_a?(WufooTheme)
      obj = object_or_id
    else
      obj = WufooTheme.find object_or_id
    end
    
    obj.css
  end

  def get_title(value)
    return if value.blank?
    "<h1><a href=\"\" id=\"logo\">#{value}</a></h1>"
  end
end