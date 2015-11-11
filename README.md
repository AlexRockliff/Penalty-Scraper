This script generates reddit formatted tables for all penalty types sorted by team  
Edit the "penaltyType" variable to change the output of the script  
Data should exist for all penalty types supported by www.nflpenalties.com back to 2009  
If supplied penalties below do not work, visit nflpenalties and find the desired penalty,  
then use the section of the URL that looks like "neutral-zone-infraction" in the "penaltyType" variable  

Usage: ruby parse.rb > output.txt  
Dependencies: Ruby, Nokogiri

Based on a script by /u/daybreaker   
All penalties:
  
Chop Block  
Clipping  
Defensive 12 On-field  
Defensive Delay of Game  
Defensive Holding  
Defensive Offside  
Defensive Pass Interference  
Delay of Game  
Disqualification  
Encroachment  
Face Mask (15 Yards)  
Fair Catch Interference  
False Start  
Horse Collar Tackle  
Illegal Blindside Block  
Illegal Block Above the Waist  
Illegal Contact  
Illegal Crackback  
Illegal Formation  
Illegal Forward Pass  
Illegal Motion  
Illegal Peelback  
Illegal Shift  
Illegal Substitution  
Illegal Touch Kick  
Illegal Touch Pass  
Illegal Use of Hands  
Ineligible Downfield Kick  
Ineligible Downfield Pass  
Intentional Grounding  
Interference with Opportunity to Catch  
Invalid Fair Catch Signal  
Kickoff Out of Bounds  
Low Block  
Neutral Zone Infraction  
Offensive 12 On-field  
Offensive Holding  
Offensive Offside  
Offensive Pass Interference  
Offside on Free Kick  
Personal Foul  
Player Out of Bounds on Punt  
Roughing the Kicker  
Roughing the Passer  
Running Into the Kicker  
Taunting  
Tripping  
Unnecessary Roughness  
Unsportsmanlike Conduct