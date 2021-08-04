class Match < ApplicationRecord
    has_many :match_teams
    has_many :teams, through: :match_teams

    def format_date_time
        min = self.date_time.min - self.date_time.min % 15
        # we want the minutes to occur in multiples of 15
        self.date_time.strftime("%A, %B %d, %Y %H:#{min}")
    end

end
