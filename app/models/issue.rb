class Issue < ActiveRecord::Base
  STA_CREATED = "created"
  STA_WORKING = "working"
  STA_RESOLVED = "resolved"
  
  belongs_to :user
  belongs_to :resolver, class_name: "User", foreign_key: :resolved_by
  has_many :responses
  
  attr_accessible :description, :status, :title, :user_id, :resolved_by
  validates_presence_of :user_id, :status
  
  before_validation :default_values
  def default_values
    self.status ||= STA_CREATED
  end
end
