class Article < ActiveRecord::Base
  has_many :article_entries, :dependent => :destroy
  has_many :categories, :through => :article_entries,  :source => :category

  attr_accessible :authorize_at, :content, :title, :authorize_at_string, :url, :source

  validates :authorize_at, :content, :title, :authorize_at_string, :url, :presence => true

  searchable do
  	string :title
    text :content
    string :source
  end
end
