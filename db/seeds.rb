# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ---- DESTROYERS ---- #
MatchTeam.destroy_all
Match.destroy_all
Team.destroy_all
College.destroy_all
Sport.destroy_all

# ---- HELPER FUNCTIONS ---- #

# creates a match either in the past or in the future
def create_matches(upcoming, num_matches, sport)
    num_matches.times do 
        # create a new match
        match = Match.new
        

        if upcoming
            match.date_time = (Time.now+rand(11000000))
        else
            match.date_time = (Time.now-rand(11000000))
        end

        match.date_time = match.format_date_time.to_datetime
        match.is_completed = 0
    
        # create two match_teams
        num_match_teams = 2

        create_match_teams(num_match_teams, match, sport)
    
        match.name = "#{match.teams[0].name} vs #{match.teams[1].name}"
        
        if !match.save
            puts "failed to save match in db"
        end
    end
end

# creates two records in the join table between two teams who have played a match
def create_match_teams(n, match, sport)
    teams_in_sport = Team.all.select{|t| t.sport_id == sport.id}
    teams_that_played = teams_in_sport.sample(n)

    teams_that_played.each do |t|
        match_team = MatchTeam.new
        match_team.match = match
        match_team.team = t
        match_team.score = 0
        match_team.save
    end
end

# TO DO: a function that goes through all matches and compares with current date to check if match is completed

# ---- SEEDED DATA ---- #

# create sports. basketball for now
sports = [
    {
        name: "Basketball",
        description: "There are three levels, A, B, and C. Players can test out which level is right for them at the beginning of the season, but must have chosen a level by January. Overtime possession determined by a coin flip.",
        location: "Lanman Center"
    }
]

Sport.create(sports)

# create colleges
count = 0 
college_names = ["Benjamin Franklin", "Berkeley", "Branford", "Davenport", "Ezra Stiles", "Grace Hopper", "Jonathan Edwards", "Morse", "Pauli Murray", "Pierson", "Saybrook", "Silliman", "Timothy Dwight", "Trumbull"]
college_names.each do |name|
    college = College.new(name: name)
    college.save
    count += 1
end

# create teams
# assumption: every college has a team for each sport
College.all.each do |c|
    team = Team.new
    team.college = c # for now
    team.name = c.name
    team.description = Faker::Lorem.paragraph # i will take the descriptions from the intramural websites
    team.sport = Sport.find_by(name: "Basketball")
    team.save  
end

# create upcoming matches for basketball
basketball_id = Sport.find_by(name:"Basketball")
create_matches(upcoming=true, 30, basketball_id)

# create past matches for basketball
create_matches(upcoming=false, 30, basketball_id)











