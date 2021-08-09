class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :class_of, :team_id
end
