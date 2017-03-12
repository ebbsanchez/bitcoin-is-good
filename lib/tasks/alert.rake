namespace :alert do
  desc "(Cron)New User alert"
  task newuser: :environment do
  	count = Alert.find_by(usage: 'user_count')

  	# if data not created yet
  	if count == nil
  		count = Alert.new(usage:'user_count', data: User.count.to_s)
  		puts "Create user count data"
  	end

  	if User.count > count.data.to_i
  		puts "#{User.count - count.data.to_i} new User !! "
  		count.data = User.count.to_s
  	end
  	count.save
  end
end
