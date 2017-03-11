class DashboardController < ApplicationController
	before_action :authenticate_user!
	before_action :get_btc_price
	before_action :get_user
	def home
		# day earn
		@day_earn = 0.0
		@month_earn = 0.0
		@user.addresses.each do |address|
			if address.updated_at.to_date > Time.now.yesterday.to_date && address.status == 'complete'
				@day_earn += address.btc_amount
			end
			if address.updated_at.to_date > (Time.now.to_date - 1.month)
			 @month_earn += address.btc_amount
			end
		end
		@month_earn = @month_earn.round(8)
		# chart
		@weekly_data = {}
		(0..6).each do |i|
			date = Time.now.to_date - (6-i).day
			day = @user.days.find_by(date: date)
			if day == nil
				@weekly_data[date] = 0
			else
				@weekly_data[date] = day.balance
			end
		end
	end

	def be_my_tutor
		if @user.email == params['tutor_email']
			flash[:error] = "無法指定自己為導師"
			redirect_to action: 'home'
		end
		# todo: if nil, render user not exist
		@tutor= User.find_by(email: params['tutor_email'])
	end

	def assign_tutor
		@tutor= User.find_by(email: params['tutor_email'])
		@user.tutor_id = @tutor.id
		@user.save
		redirect_to action: "home"
	end

	def upgrade_page
		@upgrade_level = @user.level + 1
		@coinbase = Rails.configuration.coinbase
		@tutor = get_tutor(@upgrade_level)
		@pool_money = get_pool_money(@upgrade_level)
	end

	def upgrade_check
		if @user.upgrading == true
			flash[:error] = "升級正在審核中，
				或尚未支付完畢。"
			redirect_to action: 'home'
		else
			redirect_to action: 'upgrade_pay'
		end
	end

	def upgrade_pay
		# basic data
		account_id = '383b7c1e-0381-5a2c-9e54-d716236d87e0'
		@upgrade_level = @user.level + 1
		@coinbase = Rails.configuration.coinbase
		@tutor = get_tutor(@upgrade_level)
		@user.upgrading = true
		@user.save

		# get address object
		found_adr_flag = false
		address_usage = "#{@user.level} upgrade to #{@upgrade_level}"
		@user.addresses.all.each do |adr|
			if adr.usage == address_usage && adr.status == 'waiting'
				logger.debug '[*] Found!'
				@address = adr
				found_adr_flag = true
			end
		end

		if found_adr_flag == false
			account = @coinbase.account(account_id)
			adr_label = "User" + @user.id.to_s + "_lv" + @upgrade_level.to_s
			adr_obj = account.create_address({name: adr_label})

			# create address record in our own model
			@address = @user.addresses.new
			@address.address_id = adr_obj.id
			@address.address = adr_obj.address
			@address.usage = address_usage
			@address.to_id = @tutor.id
			@address.to_email = @tutor.email
			@address.twd_amount = @upgrade_level*50
			@address.btc_amount = (@upgrade_level*50/@TWDbit).round(8)
			@address.btc_amount_expired = Time.now + 15 * 60
			@address.save
		end

	end

	# we dont need this block, cause rake handle the upgrade process
	def upgrade
		# todo: add if statement to confirmed if transaction is complete.
		# to do that, we need to pass some argv from upgrade_pay to upgrade
		redirect_to action: 'home'
	end

	def social
		@tutors = [get_tutor(1),get_tutor(2),get_tutor(3),get_tutor(4),get_tutor(5),get_tutor(6),get_tutor(7)]
	end

	def testing
		@days = Day.all
		@addresses = Address.all
		@weekly_data = {}
		(0..6).each do |i|
			date = Time.now.to_date - (6-i).day
			day = @user.days.find_by(date: date)
			if day == nil
				@weekly_data[date] = 0
			else
				@weekly_data[date] = day.balance
			end
		end
	end


	private
	def permit_params
		params.permit(:tutor_email)
	end
	# before actions
	def get_user
		@user = current_user
	end

	def get_btc_price
		@resp = HTTParty.get("https://blockchain.info/ticker")
		@USDbit = @resp["USD"]["15m"]
		@TWDbit = @resp["TWD"]["15m"]
		if @TWDbit == 0 || @USDbit == 0
			flash[:error] = "暫時無法使用"
			redirect_to action: 'home'
		end
	end

	# methods
	def get_tutor(time)
		# time = N if you are upgrade to lvN
		tutor = @user.tutor
		time = time - 1
		time.times do
			begin
	    	tutor = tutor.tutor
	    	if tutor.tutor == nil
	    		tutor = User.find(5)
	    	end
	  	rescue NoMethodError
	  		# if there is no tutor, give one.
	  		tutor = User.find(5)
			end
		end
		return tutor
	end

	def get_pool_money(upgrade_level)
		if upgrade_level == 1
			return @user.lv1_pool
		elsif upgrade_level == 2
			return @user.lv2_pool
		elsif upgrade_level == 3
			return @user.lv3_pool
		elsif upgrade_level == 4
			return @user.lv4_pool
		elsif upgrade_level == 5
			return @user.lv5_pool
		elsif upgrade_level == 6
			return @user.lv6_pool
		elsif upgrade_level == 7
			return @user.lv7_pool
		end
	end
end
