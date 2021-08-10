class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :sport_id

  belongs_to :college
  has_many :players
  has_many :matches
  has_many :match_teams
end
