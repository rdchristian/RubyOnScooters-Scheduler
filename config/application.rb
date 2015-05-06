require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyOnScootersScheduler
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'
    config.active_record.default_timezone = :local

    #Global user variables
    config.REGULAR_SCHEDULE_DAYS = 30         #initially regular users can schedule events for a month in advance
    config.STAFF_SCHEDULE_DAYS = 120           #initially staff users can schedule events any time into the future
    config.ADMIN_SCHEDULE_DAYS = 365           #initially admin users can schedule events any time into the futre


    config.TWILIO_PHONE = '+19793832682'        #Phone number from which twilio texts will be sent




    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
