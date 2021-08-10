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
Player.destroy_all
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
            match.is_completed = 0
        else
            match.date_time = (Time.now-rand(11000000))
            match.is_completed = 1
        end

        match.date_time = match.format_date_time.to_datetime
        
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
        match_team.is_winner = 0

        # if match has been played, give it a random score
        if match.is_completed
            match_team.score = rand(50)
        end
        
        match_team.save
    end

    # traverse match_teams and assign winners
    if match.is_completed
        match_teams_for_current_match = MatchTeam.all.select{|mt| mt.match == match}
        winner = match_teams_for_current_match.max{ |match_team_1, match_team_2| match_team_1.score <=> match_team_2.score}
        winner.update(is_winner: 1)
    end


  
end

# creates the teams
# assumption: every college has a team for each sport
def create_teams_for_sport(sport, num_players)
    current_year = Time.new.year
    classes = (current_year..current_year+4).to_a # for the players

    College.all.each do |c|
        team = Team.new
        team.college = c # for now
        team.name = c.name
        team.description = sport.description
        team.sport = sport

        # players
        create_players(team, classes, num_players)
        team.save  
    end 
end

# creates players for each team

def create_players(team, classes, num_players)
    num_players.times do
        player = Player.new
        player.first_name = Faker::Name.first_name 
        player.last_name = Faker::Name.last_name 
        player.team = team
        player.class_of = classes.sample
        player.save
    end
end

# ---- SEEDED DATA ---- #

# create sports.
sports = [
    {
        name: "Basketball",
        description: "There are three levels, A, B, and C. Players can test out which level is right for them at the beginning of the season, but must have chosen a level by January. Overtime possession determined by a coin flip.",
        location: "Lanman Center"
    },
    {
        name: "Pickleball",
        description: "Players volley until a fault, winner will get the option of serving
        first.",
        location: "5th floor H or K"
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

# create basketball teams
# assumption: every college has a team for each sport
basketball = Sport.find_by(name:"Basketball")
num_players = 10
create_teams_for_sport(basketball, num_players)

# create upcoming matches for basketball
create_matches(upcoming=true, 30, basketball)

# create past matches for basketball
create_matches(upcoming=false, 30, basketball)

# create pickleball teams
# assumption: every college has a team for each sport
pickleball = Sport.find_by(name:"Pickleball")
num_players = 15
create_teams_for_sport(pickleball, num_players)

# create upcoming matches for basketball
create_matches(upcoming=true, 30, pickleball)

# create past matches for basketball
create_matches(upcoming=false, 30, pickleball)














