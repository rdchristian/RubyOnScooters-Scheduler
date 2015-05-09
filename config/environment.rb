# Load the Rails application.
require File.expand_path('../application', __FILE__)

my_date_formats = { :default => '%B %-d, %Y, %-l:%M %p' } 
Time::DATE_FORMATS.merge!(my_date_formats) 
Date::DATE_FORMATS.merge!(my_date_formats)

# Initialize the Rails application.
Rails.application.initialize!
