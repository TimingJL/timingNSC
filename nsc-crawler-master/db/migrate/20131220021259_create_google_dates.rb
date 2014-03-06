class CreateGoogleDates < ActiveRecord::Migration
  def change
    create_table :google_dates do |t|
      t.date :indexed_at
      t.string :lock

      t.timestamps
    end
  end
end
