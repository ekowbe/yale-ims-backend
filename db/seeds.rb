# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Team.destroy_all
College.destroy_all
Sport.destroy_all

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

# create matches






