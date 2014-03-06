class CreateKmwPrelinks < ActiveRecord::Migration
  def change
    create_table :kmw_prelinks do |t|
      t.text :url
      t.boolean :success

      t.timestamps
    end
  end
end
