class CreateExportLogKeywords < ActiveRecord::Migration
  def change
    create_table :export_log_keywords do |t|
      t.string :keyword
      t.string :source
      t.string :name
      t.string :email
      t.string :request_type
      t.string :category_type
      t.string :file_path

      t.timestamps
    end
  end
end
