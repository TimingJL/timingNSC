class AddLockToMacrolevel < ActiveRecord::Migration
  def change
    add_column :macrolevels, :lock, :boolean
  end
end
