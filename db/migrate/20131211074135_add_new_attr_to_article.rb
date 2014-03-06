class AddNewAttrToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :source, :string
    add_column :articles, :score, :integer
    add_column :articles, :label, :integer
  end
end
