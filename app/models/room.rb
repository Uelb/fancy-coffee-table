class Room < ActiveRecord::Base
  belongs_to :first_user, class_name: 'User'
  belongs_to :second_user, class_name: 'User'
  has_many :messages
  validates_presence_of :latitude, :longitude, :first_user, :second_user,
    :displayed_for_first_user, :displayed_for_second_user,
    :first_user_profile_displayed, :second_user_profile_displayed
  validates_uniqueness_of :first_user_id, scope: :second_user_id

  def is_active?
    displayed_for_first_user && displayed_for_second_user
  end
end
