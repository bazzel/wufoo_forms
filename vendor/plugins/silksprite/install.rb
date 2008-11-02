require 'ftools'

FileUtils.cp_r("#{Silksprite::PLUGIN_PUBLIC_PATH}/.", File.join(RAILS_ROOT, 'public', 'stylesheets'))
