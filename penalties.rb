require 'rubygems'
require 'nokogiri'
require 'ostruct'
require 'open-uri'

uri = "http://www.nflpenalties.com/all-penalties.php?year=2015"
Penalties = []

doc = Nokogiri::HTML(open(uri).read)
table = doc.css('table.footable').first
rows = table.css('tbody tr')
rows.each do |row|
    cells = row.css('td')
    penaltyType = cells.first.text
    Penalties << penaltyType
end

Penalties.each{ |team| puts [team] }