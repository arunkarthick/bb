class TeamsController < ApplicationController
  active_scaffold :team do |conf|
  	conf.columns = [:name, :league, :division_name, :total_players, :players_list]
    conf.actions = [:list]
    list.per_page = DEFAULT_NUMBER_OF_LIST_ITEMS
  end	
end
