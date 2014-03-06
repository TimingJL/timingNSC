class CreateMacrolevels < ActiveRecord::Migration
  def change
    create_table :macrolevels do |t|
      t.string :name
      t.string :tag

      t.timestamps
    end
  end
end
