class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :sport_id

  belongs_to :college
end
