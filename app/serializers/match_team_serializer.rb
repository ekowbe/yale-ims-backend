class MatchTeamSerializer < ActiveModel::Serializer
  attributes :id, :match_id, :team_id, :is_winner, :score
end
