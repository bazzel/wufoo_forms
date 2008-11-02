require 'ftools'

FileUtils.cp_r("#{Wufoo::PLUGIN_STYLESHEETS_PATH}/.", File.join(RAILS_ROOT, 'public', 'stylesheets'))
FileUtils.cp_r("#{Wufoo::PLUGIN_IMAGES_PATH}/.", File.join(RAILS_ROOT, 'public', 'images'))
FileUtils.cp_r("#{Wufoo::PLUGIN_JAVASCRIPTS_PATH}/.", File.join(RAILS_ROOT, 'public', 'javascripts'))