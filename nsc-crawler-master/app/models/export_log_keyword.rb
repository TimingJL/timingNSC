class ExportLogKeyword < ActiveRecord::Base
  attr_accessible :category_type, :email, :file_path, :keyword, :name, :request_type, :source

  validates :email, :name, :keyword, :source, :presence => true
end
