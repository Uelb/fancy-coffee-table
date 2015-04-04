class Room < ActiveRecord::Base
  belongs_to :first_user, class_name: 'User'
  belongs_to :second_user, class_name: 'User'
  has_many :messages, dependent: :destroy
  before_create :generate_channel_name
  validates_presence_of :latitude, :longitude, :first_user
  validates_uniqueness_of :first_user_id, scope: :second_user_id

  def is_active?
    displayed_for_first_user && displayed_for_second_user
  end

  private
  def generate_channel_name
    self.channel_name = SecureRandom.urlsafe_base64
  end
end
