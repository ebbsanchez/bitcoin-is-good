require 'coinbase/wallet'
Rails.application.config.coinbase = Coinbase::Wallet::Client.new(api_key: 'Y1n5Phagjyrgzi4t', api_secret: 'WjafjrqixnotpG19ZTZRyWC7PWNRfUlW')