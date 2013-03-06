class ImportController < ApplicationController

  def upload
    xml_file = params[:xml_file]
    doc = Nokogiri::Slop(xml_file.read)
    # Fetching Leagues
    doc.SEASON.LEAGUE.each do |league_node|

      league_name = league_node.LEAGUE_NAME.text rescue "N/A"
      league = League.find_by_name_and_year(league_name, doc.SEASON.YEAR.text.to_i) || League.create!(:name => league_name, :year => doc.SEASON.YEAR.text.to_i)

      # Fetching divisions
      league_node.DIVISION.each do |division_node|
        division_name = division_node.DIVISION_NAME.text rescue "N/A"
        division = Division.find_by_league_id_and_name(league.id, division_node.DIVISION_NAME.text) || league.divisions.create!(:name => division_node.DIVISION_NAME.text)

        # Fetching teams
        division_node.TEAM.each do |team_node|
          team_name, team_city = (team_node.TEAM_NAME.text rescue "N/A"), (team_node.TEAM_CITY.text rescue "N/A")
          team = Team.find_by_division_id_and_name_and_city(division.id, team_name, team_city) || division.teams.create!(:name => team_name, :city => team_city)

          # Fetching Players
          team_node.PLAYER.each do |player|

            unless Player.find_by_team_id_and_surname_and_given_name(team.id, player.SURNAME.text, player.GIVEN_NAME.text)
              new_player = team.players.create!(
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
    end
    flash[:notice] = "Data is successfully imported!"
    redirect_to players_path
  end
end
