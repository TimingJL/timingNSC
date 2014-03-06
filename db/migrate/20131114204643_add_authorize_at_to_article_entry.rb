class AddAuthorizeAtToArticleEntry < ActiveRecord::Migration
  def change
    add_column :article_entries, :authorize_at, :datetime
  end
end
