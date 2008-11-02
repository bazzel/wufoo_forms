namespace :wufoo do
  desc "Add the database table needed for Wufoo themes"
  task :install => :environment do
    ActiveRecord::Schema.define do
      create_table :wufoo_themes do |t|
        t.string :theme, :css
      end
    end
    require 'active_record/fixtures'
    Fixtures.create_fixtures(Wufoo::PLUGIN_FIXTURES_PATH, 'wufoo_themes')
  end

  task :uninstall => :environment do
    ActiveRecord::Schema.define do
      drop_table :wufoo_themes
    end
  end

  task :reinstall => [:uninstall, :install]

end
