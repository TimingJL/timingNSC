class CreateKmw < ActiveRecord::Migration
  def change
    create_table :kmws do |t|
      t.string :name
      t.string :tag
      t.boolean :lock

      t.timestamps
    end
  end
end
