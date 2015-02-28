class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :room
  validates_presence_of :body, :sender, :recipient, :room
end
