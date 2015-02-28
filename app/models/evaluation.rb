class Evaluation < ActiveRecord::Base
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewed_user, class_name: 'User'
  validates_presence_of :score, :reviewer, :reviewed_user
  validates :score, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
end
