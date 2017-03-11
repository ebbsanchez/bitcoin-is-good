namespace :tran do

  desc "Check coinbase data to confirm paidment"
  task check: :environment do
		coinbase = Rails.configuration.coinbase
		account_id = '383b7c1e-0381-5a2c-9e54-d716236d87e0'
		account = coinbase.account(account_id)

		# check transaction from each address
		puts "[*] -- Start loop through all addresses! --"
		Address.all.each do |address|

			# get tansaction's address
			# get address from coinbase account
			adr = account.address(address.address_id)
			btc_recieved = 0.0
			btc_pending = 0.0

			# run through all transaction from address
			puts "[*] Address id: #{address.id}, status: #{address.status}"
			if address.status == 'waiting' || address.status == 'pending'						# Check the wating address
				adr.transactions.each do |tran| 				# Check every transaction from address
					if tran['status'] == 'completed'  			# Check if there is new income
						puts "[complete] There is #{tran['amount']['amount']}btc complete!!"
						btc_recieved += tran['amount']['amount'].to_f
						# address.save
					elsif tran['status'] == 'pending'			# For income that is still pending
						puts "[pending] There is #{tran['amount']['amount']}btc pending.."
						btc_pending += tran['amount']['amount'].to_f
						# address.btc_pending = btc_pending
						# address.save
						if btc_pending + btc_recieved == address.btc_amount
							puts "[!] Penging + recieved = btc_amount!!"
							puts "[!] Extend the btc expired time!!"
							address.btc_amount_expired = Time.now + 30 * 60
							address.status = 'pending'
						end
					end

					# if we recieved more btc.
					if btc_recieved > address.btc_recieved
						puts "[V] #{address.user.email}: #{btc_recieved - address.btc_recieved} btc recieved!"
						# update btc_recieved for next if statement
						address.btc_recieved = btc_recieved
						if address.btc_recieved >= address.btc_amount # if finish paying

							# give tutor(or the pool) the money
							tutor = User.find(address.to_id)
							if address.usage[-1].to_i <= tutor.level
								tutor.balance += address.btc_amount
							elsif address.usage[-1] == "1"
								tutor.lv1_pool += address.btc_amount
							elsif address.usage[-1] == "2"
								tutor.lv2_pool += address.btc_amount
							elsif address.usage[-1] == "3"
								tutor.lv3_pool += address.btc_amount
							elsif address.usage[-1] == "4"
								tutor.lv4_pool += address.btc_amount
							elsif address.usage[-1] == "5"
								tutor.lv5_pool += address.btc_amount
							elsif address.usage[-1] == "6"
								tutor.lv6_pool += address.btc_amount
							elsif address.usage[-1] == "7"
								tutor.lv7_pool += address.btc_amount
							end
							tutor.save

							# get pool money
							puts "[V] #{address.user.email}: upgrade!"
							address.user.level += 1
							if address.user.level == 1 && address.user.lv1_pool != 0
								address.user.balance = address.user.balance + address.user.lv1_pool
								address.user.lv1_pool = 0
								# need to add notice message
							elsif address.user.level == 2 && address.user.lv2_pool != 0
								address.user.balance = address.user.balance + address.user.lv2_pool
								address.user.lv2_pool = 0
							elsif address.user.level == 3 && address.user.lv3_pool != 0
								address.user.balance = address.user.balance + address.user.lv3_pool
								address.user.lv3_pool = 0
							elsif address.user.level == 4 && address.user.lv4_pool != 0
								address.user.balance = address.user.balance + address.user.lv4_pool
								address.user.lv4_pool = 0
							elsif address.user.level == 5 && address.user.lv5_pool != 0
								address.user.balance = address.user.balance + address.user.lv5_pool
								address.user.lv5_pool = 0
							elsif address.user.level == 6 && address.user.lv6_pool != 0
								address.user.balance = address.user.balance + address.user.lv6_pool
								address.user.lv6_pool = 0
							elsif address.user.level == 7 && address.user.lv7_pool != 0
								address.user.balance = address.user.balance + address.user.lv7_pool
								address.user.lv7_pool = 0
							end
							address.user.upgrading = false
							address.user.save

							# complete flag
							address.status = 'complete'
							address.notice = true

						end

					end
				end
				# update btc_recieved and btc_pending after transactions loop
				address.btc_recieved = btc_recieved
				address.btc_pending = btc_pending
			end
			# when finish a address, save all the things
			address.save
		end
		puts '[*] Finish Checking payment.'
  end

  task newprice: :environment do
  	Address.all.each do |address|
  		if address.status == 'waiting' && Time.now > address.btc_amount_expired
  			puts "[*] Update Address#{address.id}'s btc_amount. "
  			puts "[*] Old btc_amount -> #{address.btc_amount}btc."
				# get price
				resp = HTTParty.get("https://blockchain.info/ticker")
				USDbit = resp["USD"]["15m"]
				TWDbit = resp["TWD"]["15m"]
				# update new btc amount
				address.btc_amount = (address.twd_amount/TWDbit).round(8)
				address.btc_amount_expired = Time.now + 15 * 60
				puts "[*] New btc_amount -> #{address.btc_amount}btc."
				address.save
			end
  	end
  	puts "[*] Update btc price finish."
  end
  task addressupdate: [:check, :newprice] do
  	puts "[*] Address status updated"
  end
end
