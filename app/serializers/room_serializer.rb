class RoomSerializer < ActiveModel::Serializer
  attributes :id, :first_user_id, :second_user_id, :first_user_profile, :second_user_profile
  has_many :messages

  def first_user_profile
    if object.first_user_profile_displayed
      object.first_user
    end
  end
  def second_user_profile
    if object.second_user_profile_displayed
      object.second_user
    end    
  end
end