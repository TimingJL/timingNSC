class GoogleDate < ActiveRecord::Base
  has_many :article_entries, :as => :category, :dependent => :destroy
  has_many :articles, :through => :article_entries,  :source => :article

  attr_accessible :indexed_at, :lock
end
