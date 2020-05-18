class AddFinishTimeToRoutines < ActiveRecord::Migration[5.2]
  def change
    add_column :routines, :finish_time, :time
  end
end
