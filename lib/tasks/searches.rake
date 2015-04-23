desc "Remove searches older than a month, need to do automatically using whatever gem"
task :remove_old_searches => :environment do
	Search.delete_all ["created_at < ?", 1.month.ago]
end