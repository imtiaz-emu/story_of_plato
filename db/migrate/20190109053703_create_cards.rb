class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer     :project_id
      t.string      :title
      t.text        :description
      t.string      :color, default: '#0000FF'


      t.timestamps
    end
  end
end
