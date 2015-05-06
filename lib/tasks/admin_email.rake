desc 'send admin email'
task send_admin_email :environment do
	UserMailer.admin_email.deliver!
end