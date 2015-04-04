class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :authentication_token
  # has_many :pictures
end