class AddColumnSubascriptionDurationTypeToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :duration_type, :string
  end
end
