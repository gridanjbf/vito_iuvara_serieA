# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

%w(Atalanta Bologna Cremonese Empoli Fiorentina Inter Juventus Lazio Lecce Milan Monza Napoli Roma Salernitana
Sampdoria Sassuolo Spezia Torino Udinese Verona).each do |t|
  Team.create(name: t)
end
["2022/23"].each do |year|
  38.times do |i|
    Matchday.create(sequence_number: i+1, match_years: year)
  end
end
