class CreateRoutines < ActiveRecord::Migration[5.2]
  def change
    create_table :routines do |t|
      t.integer :user_id
      t.string :title, null: false
      t.text :comment
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
