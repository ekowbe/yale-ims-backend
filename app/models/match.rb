class Match < ApplicationRecord
    has_many :match_teams
    has_many :teams, through: :match_teams

    def format_date_time
        min = self.date_time.min - self.date_time.min % 15
        # we want the minutes to occur in multiples of 15
        self.date_time.strftime("%A, %B %d, %Y %H:#{min}")
    end

    # TO DO: a function that goes through all matches and compares with current date to check if match is completed
    def self.update_match_completion_status()
        matches = Match.all
        matches.each |match| do
            if match.date_time < DateTime.current.to_date
                match.is_completed = 1
            end
        end
    end

end
