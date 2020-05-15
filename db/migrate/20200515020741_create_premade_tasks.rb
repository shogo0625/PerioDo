class CreatePremadeTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :premade_tasks do |t|
      t.integer :user_id
      t.text :content, null: false
      t.time :time

      t.timestamps
    end
  end
end
