class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Associations
  has_many :rooms_as_first_user, class_name: 'Room', foreign_key: :first_user_id
  has_many :rooms_as_second_user, class_name: 'Room', foreign_key: :second_user_id
  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id
  has_many :received_messages, class_name: 'Message', foreign_key: :recipient_id
  has_many :sent_evaluations, class_name: 'Evaluation', foreign_key: :reviewer_id
  has_many :received_evaluations, class_name: 'Evaluation', foreign_key: :reviewed_user_id
  
  # Validations
  validates_presence_of :email, :password, :username
  validates :min_age, numericality: {greater_than_or_equal_to: 18, less_than_or_equal_to: 80}
  validates :max_age, numericality: {greater_than_or_equal_to: 18, less_than_or_equal_to: 80}
  
  #Others
  reverse_geocoded_by :latitude, :longitude
  before_create :generate_token
  mount_uploaders :pictures, PictureUploader
    
  # Instance methods
  def rooms
    if self.new_record?
      []
    else
      Room.where("first_user_id = :user_id OR second_user_id = :user_id", user_id: id)
    end
  end

  def active_rooms
    if self.new_record?
      []
    else
      rooms.select(&:is_active?)
    end
  end
  def name
    "#{firstname} #{lastname}".strip
  end
  def around(kms=5)
    if latitude && longitude
      User.near([latitude, longitude], kms, units: :km)
    else
      []
    end
  end

  def average_score
    received_evaluations.average(:score)
  end

  # Class methods
  def self.around(latitude, longitude, kms=5)
    User.near([latitude, longitude], kms, units: :km)
  end

  private
  def generate_token
    self.authentication_token = loop do
      random_authentication_token = SecureRandom.urlsafe_base64(nil, false)
      break random_authentication_token unless User.exists?(authentication_token: random_authentication_token)
    end
  end
end
