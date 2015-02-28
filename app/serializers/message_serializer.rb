class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :first_user_id, :second_user_id, :created_at, :updated_at
end