class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string      :name, unique: true
      t.text        :description
      t.integer     :created_by

      t.timestamps
    end
  end
end
