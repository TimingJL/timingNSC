class RemoveKeywordIdToArticleEntry < ActiveRecord::Migration
  def up
    remove_column :article_entries, :keyword_id
  end

  def down
    add_column :article_entries, :keyword_id, :integer
  end
end
