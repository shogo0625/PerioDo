class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.text :content, null: false
      t.integer :status, null: false, default: 0
      t.datetime :time_limit

      t.timestamps
    end
  end
end
