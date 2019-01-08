class CreateProjectUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_users do |t|
      t.integer     :user_id
      t.integer     :project_id
      t.boolean     :additional_user, default: false
      t.datetime    :start_date
      t.datetime    :end_date

      t.timestamps
    end
  end
end
