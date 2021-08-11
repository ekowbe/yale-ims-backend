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

# attaches pictures for each sport

# def attach_pictures_to_sport(sport, num_pics)
#     count = 1
#     num_pics.times do 
#         sport.images.attach(
#             io: File.open("../yale-ims-frontend/src/sport-images/#{sport.name}/#{count}.jpg"),
#             filename: "#{count}.jpg",
#             content_type: 'application/png',
#             identify: false
#         )

#         sport.save
#         count += 1
#     end
# end

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
    },
    {
        name: "Water Polo",
        description: "You can only touch the ball with one hand at a time. You can flip
        other players out of their tubes when one of you has the ball. You
        cannot play when you are out of your tube.",
        location: "PWG 3rd Floor Pool"
    },
    {
        name: "Dodgeball",
        description: "A team cannot possess all 6 balls for more than 5 seconds. If held
        for more than 5 seconds, 3 shall be returned to the other team.
        No head shots. Ball can be used to block as long as blocking ball is
        not dropped. Ball is live until it hits floor, ceiling, backboard/net,
        or walls. If ball is caught, thrower is out and player who has been
        out the longest on catching team returns.",
        location: "Room K, 5th floor
        of PWG"
    }
]

Sport.create(sports)

# create colleges
count = 0 
college_names = ["Benjamin Franklin", "Berkeley", "Branford", "Davenport", "Ezra Stiles", "Grace Hopper", "Jonathan Edwards", "Morse", "Pauli Murray", "Pierson", "Saybrook", "Silliman", "Timothy Dwight", "Trumbull"]
college_names.each do |name|
    college = College.new(name: name)

    college.shield.attach(
        io: File.open("app/assets/images/yale-crests/shield_#{count}.png"),
        filename: "shield_#{count}.png",
        content_type: 'application/png',
        identify: false
    )

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

# save images to basketball model
# attach_pictures_to_sport(basketball, 10)
















