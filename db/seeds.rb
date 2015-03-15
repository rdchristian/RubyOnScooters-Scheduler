# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

sample_facilities = [
  {:name => 'Chair', :description => 'Used for sitting'},
  {:name => 'Video Projector', :description => 'Thingamajigy to project light on clear flat surfaces'},
  {:name => 'Poor Volunteer', :description => 'Free labor'},
  {:name => 'Auditorium Corner 4a', :description => 'Boring boring b0r1nG'}
]
 
sample_facilities.each do |facility|
  Facility.create!(facility)
end