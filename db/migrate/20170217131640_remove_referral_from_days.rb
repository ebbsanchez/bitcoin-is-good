class RemoveReferralFromDays < ActiveRecord::Migration
  def change
  	remove_column :days, :referral
  end
end
