class UserSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :birthday, :gender
  has_many :pictures
end