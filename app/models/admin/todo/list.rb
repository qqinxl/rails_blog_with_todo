class Admin::Todo::List < ActiveRecord::Base
  belongs_to :todo_tag
  belongs_to :user
  
  attr_accessible :completed_at, :deleted_at, :description, :due_date, :name, :starred
  attr_accessible :user
  attr_accessible :todo_tag
  
  validates :name,  :presence => true,:uniqueness=>true
end
