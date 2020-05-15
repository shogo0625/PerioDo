class CreateRoutineTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :routine_tasks do |t|
      t.integer :routine_id
      t.text :content, null: false
      t.time :time

      t.timestamps
    end
  end
end
