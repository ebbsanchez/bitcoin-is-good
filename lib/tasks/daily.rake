namespace :daily do
  desc "Save Daily balance record"
  task balance: :environment do
  	date = Time.now
  	User.order(id: :asc).each do |user|
  		day = user.days.new(balance: user.balance, date: date)
  		day.save
		end
		puts '[rake] Update daily balance complete!'
  end
end
