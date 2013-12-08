class AddTrialExpiredToUser < ActiveRecord::Migration
  def change
    add_column :users, :trial_expired, :boolean, default: false
  end
end
