class TaskLog < ActiveRecord::Base
  belongs_to :category, :polymorphic => true
  
  attr_accessible :category_id, :category_type, :duration
end
