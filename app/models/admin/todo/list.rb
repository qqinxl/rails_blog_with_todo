class Admin::Todo::List < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user
  
  attr_accessible :completed_at, :deleted_at, :description, :due_date, :title, :starred
  attr_accessible :user
  attr_accessible :todo_tag_id, :tag_id, :tag
  
  validates :title,  :presence => true, :uniqueness=>true
  validates :todo_tag_id,  :presence => true
  validates :due_date,  :presence => true
  
  # default_scope where("deleted_at IS NULL").order("starred DESC, created_at ASC")
  
  def self.starred
    where(:starred => true).active
  end

  def self.today
    d = DateTime.now.end_of_day
    where(:due_date => d-1.day..d).active
  end
  
  
  def is_deleted?
    !(self.deleted_at == nil)
  end
  
  def is_starred?
    (self.starred)
  end
  
  def is_today?
    self.due_date.today?
  end
  
  def is_past?
    self.due_date < Date.today
  end
  
  def icon
    icon = ""
    icon += "●" if self.completed_at
    icon += "☆" if self.is_starred?
    icon += "△" if self.is_today?
    icon += "▽" if self.is_past?
    return icon
  end
end
