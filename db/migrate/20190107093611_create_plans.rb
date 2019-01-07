class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.integer     :no_of_users, default: 1
      t.boolean     :unlimited_boards, default: false
      t.boolean     :active, default: true
      t.string      :type
      t.float       :monthly_price, default: 0.0
      t.float       :annual_price, default: 0.0
      t.float       :additional_user, default: 0.0

      t.timestamps
    end
  end
end
