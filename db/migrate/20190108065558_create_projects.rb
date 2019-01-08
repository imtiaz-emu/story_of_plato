class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string    :name
      t.integer   :creator_id
      t.string    :creator_type
      t.boolean   :active, default: true

      t.timestamps
    end
  end
end
