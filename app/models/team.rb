class Team < ApplicationRecord
  belongs_to :college
  belongs_to :sport
  has_many :match_teams
  has_many :matches, through: :match_teams
end
