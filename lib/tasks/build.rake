namespace :build do
  desc "build default users"
  task users: :environment do
  	names = ['Johnson', "Angle","LisaPD","ChaoCiao", "Meme", "Lisp", "Micak"]
	  emails = []
	  (0..6).each do |i|
	  	if i == 0
	  		i = 7
	  	end
	  	puts i
	  	tutor = i
  	  u = User.create({
	  		email: "#{names[i]}#{i*5678}@gmail.com",
	  		password: "simple521",
	  		level: 7,
	  		balance: 0.0,
	  		username: names[i],
	  		tutor_id: tutor
			})
	  	 puts u.save
	  end
  end

end
