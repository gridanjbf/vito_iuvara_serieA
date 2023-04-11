# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


#https://fixturedownload.com/view/json/serie-a-2022
data = JSON.parse(File.read(Rails.root.join("app","data/2022_23.json")))

season = "2022/23"
data.each do |datum|
  next if datum["HomeTeamScore"].nil? # not yet occurred
  m = Match.new(
    away_score: datum["AwayTeamScore"],
    home_score: datum["HomeTeamScore"],
    round: datum["RoundNumber"],
    season: season)
  m.home = Team.find_or_create_by(name: datum["HomeTeam"])
  m.away = Team.find_or_create_by(name: datum["AwayTeam"])
  m.save!
end

Match.order(round: :asc).map(&:assign_points)
