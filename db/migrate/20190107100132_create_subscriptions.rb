class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer   :plan_subscriber_id
      t.string    :plan_subscriber_type
      t.integer   :plan_id
      t.datetime  :start_date
      t.datetime  :end_date
      t.integer   :duration
      t.float     :total_cost, default: 0.00
      t.integer   :project_id

      t.timestamps
    end
  end
end
