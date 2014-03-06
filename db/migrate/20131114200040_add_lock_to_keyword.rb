class AddLockToKeyword < ActiveRecord::Migration
  def change
    add_column :keywords, :lock, :boolean
  end
end
