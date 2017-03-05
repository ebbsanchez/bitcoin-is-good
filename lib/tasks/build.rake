namespace :build do
  desc "build default users"
  task users: :environment do
  	names = ['Johnson', "Angle","LisaPD","ChaoCiao", "Meme", "Lisp", "Micak"]
	  (0..6).each do |i|
	  	puts i
	  	tutor = 7-i
  	  u = User.create({
	  		email: "data#{i}@gmail.com",
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
