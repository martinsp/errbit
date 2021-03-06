require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'rails/all'
require 'digest/md5'

Bundler.require(:default, Rails.env)

module Errbit
  class Application < Rails::Application



    #!!!WARNING!!! remove this
    config.action_controller.permit_all_parameters = true




    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += [Rails.root.join('lib')]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.active_record.observers = :notice_observer, :deploy_observer

    # > rails generate - config
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => false
      g.fixture_replacement :fabrication
    end

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Configure Devise mailer to use our mailer layout.
    config.to_prepare { Devise::Mailer.layout "mailer" }


    # Enable the asset pipeline
    config.assets.enabled = true

    # Need to initialize Rails environment for issue_tracker_icons.css.erb
    config.assets.initialize_on_precompile = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end

