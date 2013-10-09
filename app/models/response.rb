class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue
  
  attr_accessible :issue_id, :message, :user_id
end
