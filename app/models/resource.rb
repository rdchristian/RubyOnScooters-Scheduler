class Resource < ActiveRecord::Base
	attr_accessible :name, :description, :numberOf, :storage_location, :max_reserve_time
	
	has_and_belongs_to_many :events

	validates :name, :presence => true, :uniqueness => true, on: :create

	def self.search(q)
		free_resources = Array.new
		Resource.all.each do |res|
			free_resources.push(res) if res.is_available?(q)
			#res.events.where("start_date = ? and ((start <= ? and ending <= ?) or (start >= ? and ending >= ?))",q[:start_date],q[:ending],q[:ending],q[:start],q[:start])
		end
		return free_resources
	end

	def is_available?(q)
		if events.where("start <= ? and ending >= ?",q[:ending],q[:start]).count > 0
			return false
		else
			return true
		end
	end
end
