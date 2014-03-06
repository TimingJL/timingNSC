class RemoveArticleEntryIdToArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :article_entry_id
  end

  def down
    add_column :articles, :article_entry_id, :integer
  end
end
