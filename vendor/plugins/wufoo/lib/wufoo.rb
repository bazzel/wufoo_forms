# Wufoo
module Wufoo
  PLUGIN_NAME = 'wufoo'
  PLUGIN_PATH = "#{RAILS_ROOT}/vendor/plugins/#{PLUGIN_NAME}"
  PLUGIN_PUBLIC_PATH = "#{PLUGIN_PATH}/assets"
  PLUGIN_VIEWS_PATH = "#{PLUGIN_PATH}/app/views"
  PLUGIN_MODELS_PATH = "#{PLUGIN_PATH}/app/models"
  PLUGIN_FIXTURES_PATH = "#{PLUGIN_PUBLIC_PATH}/fixtures"
  
  # This is the default directory structure of a downloaded Wufoo template.
  PLUGIN_STYLESHEETS_PATH = "#{PLUGIN_PUBLIC_PATH}/css"
  PLUGIN_IMAGES_PATH = "#{PLUGIN_PUBLIC_PATH}/images"
  PLUGIN_JAVASCRIPTS_PATH = "#{PLUGIN_PUBLIC_PATH}/scripts"
  
end