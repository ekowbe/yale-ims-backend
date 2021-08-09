class MatchSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_completed, :date_time

  has_many :match_teams
end
