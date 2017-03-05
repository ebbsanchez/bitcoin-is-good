class TransactionsController < ApplicationController
	def index
		@user = current_user
		client = Rails.configuration.coinbase
		account = client.account("383b7c1e-0381-5a2c-9e54-d716236d87e0")
		@addresses = account.addresses
		@adrs = @user.addresses
	end

	def show
		@address = Address.find(params[:id])

		# # rake task will handle it
		# # check if payment have payed.
		# # coinbase
		# coinbase = Rails.configuration.coinbase
		# account_id = '383b7c1e-0381-5a2c-9e54-d716236d87e0'
		# account = coinbase.account(account_id)
		# # get address from coinbase account
		# adr = account.address(@address.address_id)

		# # check every transaction from address
		# btc_recieved = 0.0
		# adr.transactions.each do |tran|
		# 	# todo: check if btc payment is comfirm
		# 	# check if there is new income
		# 	btc_recieved += tran['amount']['amount'].to_f
		# 	if btc_recieved > @address.btc_recieved
		# 		# update btc_recieved
		# 		@address.btc_recieved = btc_recieved
		# 		# if finish paying
		# 		if @address.btc_recieved >= @address.btc_amount
		# 			@address.status = 'complete'
		# 			@address.notice = true
		# 		end
		# 	end
		# 	@address.save
		# end

		# # rake task will handle it
		# # price update
		# if @address.status == 'waiting' && Time.now > @address.btc_amount_expired
		# 	# get price
		# 	@resp = HTTParty.get("https://blockchain.info/ticker")
		# 	@USDbit = @resp["USD"]["15m"]
		# 	@TWDbit = @resp["TWD"]["15m"]
		# 	# update new btc amount
		# 	@address.btc_amount = (@address.twd_amount/@TWDbit).round(8)
		# 	@address.btc_amount_expired = Time.now + 15 * 60
		# 	@address.save
		# end
	end

	def new
		@transaction = Transaction.new
	end

	def create
		@transaction = Transaction.new
	end

	def edit
		@transaction = Transaction.find(params[:id])
	end

	def update
		@transaction = Transaction.find(params[:id])
	end

	def destroy
		@transaction = Transaction.find(params[:id])
	end
	private
end
