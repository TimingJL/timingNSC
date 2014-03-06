class ArticleEntry < ActiveRecord::Base
  belongs_to :category, :polymorphic => true
  belongs_to :article

  attr_accessible :category_type, :category_id, :article_id
end
