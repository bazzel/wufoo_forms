# Silksprite
module Silksprite
  PLUGIN_NAME = 'silksprite'
  PLUGIN_PATH = "#{RAILS_ROOT}/vendor/plugins/#{PLUGIN_NAME}"
  PLUGIN_PUBLIC_PATH = "#{PLUGIN_PATH}/assets"

  module IncludesHelper
    def silksprite_stylesheets
      stylesheet_link_tag 'sprite', 'sprite_overrides', :media => 'screen, print'
    end
  end

end