class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :rooms_as_first_user, class_name: 'Room', foreign_key: :first_user_id
  has_many :rooms_as_second_user, class_name: 'Room', foreign_key: :second_user_id
  mount_uploaders :pictures, PictureUploader
  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id
  has_many :received_messages, class_name: 'Message', foreign_key: :recipient_id
  has_many :sent_evaluations, class_name: 'Evaluation', foreign_key: :reviewer_id
  has_many :received_evaluations, class_name: 'Evaluation', foreign_key: :reviewed_user_id
  validates_presence_of :email, :password, :firstname, :lastname
  validates :min_age, numericality: {greater_than_or_equal_to: 18, less_than_or_equal_to: 80}
  validates :max_age, numericality: {greater_than_or_equal_to: 18, less_than_or_equal_to: 80}
  reverse_geocoded_by :latitude, :longitude
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
  def self.around(latitude, longitude, kms=5)
    User.near([latitude, longitude], kms, units: :km)
  end
  def average_score
    received_evaluations.average(:score)
  end
end
