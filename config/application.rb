require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BattleshipWeb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.before_initialize do |app|
      app.config.paths.add 'app/services/values', :eager_load => true
      app.config.paths.add 'app/services/errors', :eager_load => true
    end

    config.to_prepare do
      Dir[ File.expand_path(Rails.root.join("app/services/values/*.rb")) ].each do |file|
        require_dependency file
      end
      Dir[ File.expand_path(Rails.root.join("app/services/errors/*.rb")) ].each do |file|
        require_dependency file
      end
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
