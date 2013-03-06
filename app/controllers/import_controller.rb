class ImportController < ApplicationController
  def index

  end

  def upload
  	xml_file = params[:xml_file]
  	doc = Nokogiri::Slop(xml_file.read)
  	doc.SEASON.LEAGUE.each do |league|
  	  league_name = league.LEAGUE_NAME.text rescue "N/A"
  	  new_league = League.create!(:name => league_name, :year => doc.SEASON.YEAR.text)
  	  league.DIVISION.each do |division|
  	  	division_name = division.DIVISION_NAME.text rescue "N/A"
  	  	new_division = new_league.divisions.create!(:name => division.DIVISION_NAME.text)
  	  	division.TEAM.each do |team|
  	  	  team_name, team_city = (team.TEAM_NAME.text rescue "N/A"), (team.TEAM_CITY.text rescue "N/A")
  	  	  new_team = new_division.teams.create!(:name => team_name, :city => team_city)
  	  	  team.PLAYER.each do |player|
  	  	  	new_player = new_team.players.create!(
  	  	  		:surname => player.SURNAME.text,
  	  	  		:given_name => player.GIVEN_NAME.text,
  	  	  		:hr => (player.HOME_RUNS.text.to_i rescue 0),
  	  	  		:rbi => (player.RBI.text rescue 0.0),
  	  	  		:runs => (player.RUNS.text rescue 0.0),
  	  	  		:sb => (player.STEALS.text rescue 0.0),
              :average => Player.calculate_average(player),
  	  	  		:ops => Player.calculate_ops(player)
  	  	  		)
  	  	  end
  	  	end
  	  end
    end
    flash[:notice] = "Data is successfully imported!"
    redirect_to players_path
  end
end
