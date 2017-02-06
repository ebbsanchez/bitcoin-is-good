class DashboardController < ApplicationController
	before_action :authenticate_user!
	before_action :get_btc_price
	def home

	end
	def upgrade_page
		@upgrade_level = current_user.level + 1
		@coinbase = Rails.configuration.coinbase
	end

	def upgrade
		@user = current_user
		@user.level = @user.level + 1

		# move the pool money to balance
		if @user.level == 1 && @user.lv1_pool != 0
			@user.balance = @user.balance + @user.lv1_pool
			# need to ad notice message
		elsif @user.level == 2 && @user.lv2_pool != 0
			@user.balance = @user.balance + @user.lv2_pool
		elsif @user.level == 3 && @user.lv3_pool != 0
			@user.balance = @user.balance + @user.lv3_pool
		elsif @user.level == 4 && @user.lv4_pool != 0
			@user.balance = @user.balance + @user.lv4_pool
		elsif @user.level == 5 && @user.lv5_pool != 0
			@user.balance = @user.balance + @user.lv5_pool
		elsif @user.level == 6 && @user.lv6_pool != 0
			@user.balance = @user.balance + @user.lv6_pool
		elsif @user.level == 7 && @user.lv7_pool != 0
			@user.balance = @user.balance + @user.lv7_pool
		end

		@user.save
		redirect_to action: 'home'
	end

	private

	def get_btc_price
		@resp = HTTParty.get("https://blockchain.info/ticker")
		@USDbit = @resp["USD"]["15m"]
		@TWDbit = @resp["TWD"]["15m"]
	end
end
