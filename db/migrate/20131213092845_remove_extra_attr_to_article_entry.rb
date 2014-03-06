class RemoveExtraAttrToArticleEntry < ActiveRecord::Migration
  def up
    remove_column :article_entries, :authorize_at
    remove_column :article_entries, :title
    remove_column :article_entries, :url
  end

  def down
    add_column :article_entries, :url, :text
    add_column :article_entries, :title, :string
    add_column :article_entries, :authorize_at, :datetime
  end
end
