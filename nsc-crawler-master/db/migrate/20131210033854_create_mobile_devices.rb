class CreateMobileDevices < ActiveRecord::Migration
  def change
    create_table :mobile_devices do |t|
      t.string :email
      t.string :registration_id

      t.timestamps
    end
  end
end
