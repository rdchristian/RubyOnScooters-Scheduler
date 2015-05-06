namespace :send do
	desc 'Sending admin email'
	task admin_email :environment do
		UserMailer.admin_email.deliver!
end
