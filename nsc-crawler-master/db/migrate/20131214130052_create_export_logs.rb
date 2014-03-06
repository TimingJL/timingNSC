class CreateExportLogs < ActiveRecord::Migration
  def change
    create_table :export_logs do |t|
      t.string :name
      t.string :email
      t.string :request_type
      t.string :category_type
      t.string :category_id
      t.string :file_path

      t.timestamps
    end
  end
end
