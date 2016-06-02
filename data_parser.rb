require 'csv'
require 'erb'


deliveries =[]

CSV.foreach('planet_express_logs.csv', headers: true) do |row|
  deliveries_hash = row.to_hash
  deliveries << deliveries_hash
end

# How much money did we make this week?
income= []
deliveries.each {|delivery| income << delivery["Money"].to_i }
total_income = income.reduce(:+)


# How much of a bonus did each employee get?
fry_cash = 0  #Earth
amy_cash = 0  #Mars
bender_cash = 0  #Uranus
leela_cash = 0   #Everywhere Else

# How many trips did each employee pilot?
fry_trips = 0
amy_trips = 0
bender_trips = 0
leela_trips = 0

deliveries.each do |delivery|
  case delivery["Destination"]
    when "Earth"
      fry_cash= fry_cash + delivery["Money"].to_i
      fry_trips += 1
    when "Mars"
      amy_cash= amy_cash + delivery["Money"].to_i
      amy_trips += 1
    when "Uranus"
      bender_cash= bender_cash + delivery["Money"].to_i
      bender_trips += 1
    else
      leela_cash= leela_cash + delivery["Money"].to_i
      leela_trips += 1
  end
end

fry_bonus = (fry_cash * 0.1).to_i
amy_bonus = (amy_cash * 0.1).to_i
bender_bonus = (bender_cash * 0.1).to_i
leela_bonus = (leela_cash * 0.1).to_i



# List of all employees and their number of trips and bonus
employees = [{
  name: "Fry",
  bonus: fry_bonus,
  trips: fry_trips
},{
name: "Amy",
bonus: amy_bonus,
trips: amy_trips
},{
name: "Bender",
bonus: bender_bonus,
trips: bender_trips
},{
name: "Leela",
bonus: leela_bonus,
trips: leela_trips
}]




















#ERB Stuff
report = File.read("report.html")
compiled_report= ERB.new(report).result(binding)
File.open("compiled_report.html", "wb") {|file| file << compiled_report}

puts report
