class AddArticleIdToArticleEntry < ActiveRecord::Migration
  def change
    add_column :article_entries, :article_id, :integer
  end
end
