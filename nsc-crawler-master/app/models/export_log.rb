class ExportLog < ActiveRecord::Base
  attr_accessible :category_id, :category_type, :email, :file_path, :name, :request_type

  validates :email, :name, :presence => true
end
