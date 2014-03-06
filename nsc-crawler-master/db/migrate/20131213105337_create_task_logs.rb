class CreateTaskLogs < ActiveRecord::Migration
  def change
    create_table :task_logs do |t|
      t.string :duration
      t.string :category_type
      t.integer :category_id

      t.timestamps
    end
  end
end
