class AddUrlToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :url, :text
  end
end
