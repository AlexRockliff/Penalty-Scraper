require 'rubygems'
require 'nokogiri'
require 'ostruct'
require 'open-uri'

penaltyType = "Face Mask (15 Yards)"


baseURI = "http://www.nflpenalties.com/penalty/"
baseExtension = "?year="
slug = penaltyType.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
uri = baseURI + slug + baseExtension

teams = []

(2009..2015).each do |year|
    doc = Nokogiri::HTML(open(uri + year.to_s).read)
    table = doc.css('table.footable').first
    rows = table.css('tbody tr')

    rows.each do |row|
        cells = row.css('td')
        teamName = cells.first.text
        team = teams.find {|t| t.name == teamName}
        if team.nil?
            team = OpenStruct.new(name: teamName, 
                f_total: 0, f_home: 0, f_away: 0, f_declined: 0, f_yards: 0, f_thisYear: 0, f_thisYearYards: 0, f_thisYearHome: 0, f_thisYearAway: 0, f_thisYearDeclined: 0,
                a_total: 0, a_home: 0, a_away: 0, a_declined: 0, a_yards: 0, a_thisYear: 0, a_thisYearYards: 0, a_thisYearHome: 0, a_thisYearAway: 0, a_thisYearDeclined: 0)
            teams << team
        end

        #FOR
        team.f_total += cells[7].text.to_i
        team.f_yards += cells[8].text.to_i
        team.f_declined += cells[9].text.to_i
        team.f_home += cells[10].text.to_i
        team.f_away += cells[11].text.to_i
        if year == 2015
            team.f_thisYear = cells[7].text.to_i
            team.f_thisYearYards = cells[8].text.to_i
            team.f_thisYearDeclined = cells[0].text.to_i
            team.f_thisYearHome = cells[10].text.to_i
            team.f_thisYearAway = cells[11].text.to_i
        end

        #AGAINST
        team.a_total += cells[2].text.to_i
        team.a_yards += cells[3].text.to_i
        team.a_declined += cells[4].text.to_i
        team.a_home += cells[5].text.to_i
        team.a_away += cells[6].text.to_i
        if year == 2015
            team.a_thisYear = cells[2].text.to_i
            team.a_thisYearYards = cells[3].text.to_i
            team.a_thisYearDeclined = cells[4].text.to_i
            team.a_thisYearHome = cells[5].text.to_i
            team.a_thisYearAway = cells[6].text.to_i
        end
    end
end

puts "**" + penaltyType + "**"
puts ""
puts "**Team** | **Total For** | Home For | Away For | Declined For | Yards For | **Total Against** | Home Against | Away Against | Declined Against | Yards Against"
puts ":--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:"
teams.each{ |team| puts [team.name, "**#{team.f_total}** (#{team.f_thisYear})", "**#{team.f_home.to_s}** (#{team.f_thisYearHome})", 
    "**#{team.f_away.to_s}** (#{team.f_thisYearAway})", "**#{team.f_declined.to_s}** (#{team.f_thisYearDeclined})", "**#{team.f_yards.to_s}** (#{team.f_thisYearYards})", 
    "**#{team.a_total.to_s}** (#{team.a_thisYear})", "**#{team.a_home.to_s}** (#{team.a_thisYearHome})", "**#{team.a_away.to_s}** (#{team.a_thisYearAway})", 
    "**#{team.a_declined.to_s}** (#{team.a_thisYearDeclined})", "**#{team.a_yards.to_s}** (#{team.a_thisYearYards})"].join(" | ") }

puts ""
avg_year = teams.inject(0){ |sum, t| sum += t.a_total }
avg_year_adjusted = teams.inject(0){ |sum, t| sum += t.a_total } - teams.inject(0){ |sum, t| sum += t.a_thisYear }
avg_yardage = teams.inject(0){ |sum, t| sum += t.a_yards }
avg_yardage_adjusted = teams.inject(0){ |sum, t| sum += t.a_yards } - teams.inject(0){ |sum, t| sum += t.a_thisYearYards }
puts "Average per team: #{avg_year/32.0}  "
puts "Average per team per year: #{(avg_year_adjusted/32.0)/6.0}  "
puts "Average yardage per team: #{(avg_yardage/32.0)}  "
puts "Avegage yardage per team per year: #{(avg_yardage_adjusted/32.0)/6.0}  "

puts ""
puts "**Top 10**"
puts ""
puts "Team | #{penaltyType}"
puts ":--|--:"
teams.sort { |b, a| a.a_total <=> b.a_total }.take(10).each{|x| puts x.name + " | " + x.a_total.to_s + " (this year: #{x.a_thisYear})";}

puts ""
puts "**Top 10 Away**"
puts ""
puts "Team | #{penaltyType}"
puts ":--|--:"
teams.sort { |b, a| a.a_away <=> b.a_away }.take(10).each{|x| puts x.name + " | " + x.a_away.to_s  + " (this year: #{x.a_thisYearAway})";}

puts ""
puts "Team | Differential"
puts ":--|--:"
teams.sort { |b, a| (a.f_total - a.a_total) <=> (b.f_total - b.a_total) }.each{|x| puts x.name + " | " + sprintf("%+d", x.f_total - x.a_total);}