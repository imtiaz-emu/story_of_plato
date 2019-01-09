class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer   :card_id
      t.string    :detail, limit: 288
      t.boolean   :completed, default: false

      t.timestamps
    end
  end
end
