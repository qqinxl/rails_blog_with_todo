class Admin::Todo::Tag < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :static
  attr_accessible :user
  
  validates :name,  :presence => true,:uniqueness=>true
end
