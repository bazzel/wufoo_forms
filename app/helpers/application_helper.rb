# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Retourneert een link voor het uitbreiden
  # van een subform met een partial voor object.
  # >> add_sub_link "Categorie toevoegen", 
  #                 :categories, 
  #                 :object => Category, :partial => 'category'
  def add_sub_link(name) 
    content_tag :li, :class => 'buttons' do
      link_to(ss_span("application_form_add") + name, '', :class => 'button', :id => 'add_bar')
      end 

  end 
  
end
