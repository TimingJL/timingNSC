class AddCategoryToArticleEntry < ActiveRecord::Migration
  def change
    add_column :article_entries, :category_id, :integer
    add_column :article_entries, :category_type, :string
  end
end
