class CreateJoinTableOrganizationUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :organizations, :users do |t|
      t.index [:organization_id, :user_id]
    end
  end
end
