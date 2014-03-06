class Macrolevel < ActiveRecord::Base
  has_many :article_entries, :as => :category, :dependent => :destroy
  has_many :articles, :through => :article_entries,  :source => :article

  has_many :task_logs, :as => :category, :dependent => :destroy

  attr_accessible :name, :tag, :lock
end
