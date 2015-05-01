# lib/tasks/delete_old_records.rake
namespace :delete do
  desc 'Delete events that are over a year old'
  task :old_events => :environment do
    Event.where('created_at < ?', 1.year.ago).each do |event|
      event.destroy
    end
  end
end