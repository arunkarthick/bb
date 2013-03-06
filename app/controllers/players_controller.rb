class PlayersController < ApplicationController
  active_scaffold :player do |conf|
    conf.columns = [:league, :division, :given_name, :surname, :team, :average, :hr, :rbi, :runs, :sb, :ops]
    list.sorting = {:average => 'DESC'}
    conf.actions = [:list]
    list.per_page = DEFAULT_NUMBER_OF_LIST_ITEMS
    conf.columns[:hr].label = "HR"
    conf.columns[:rbi].label = "RBI"
    conf.columns[:sb].label = "SB"
    conf.columns[:ops].label = "OPS"
  end

  def show
  	@player = Player.find params[:id]
  end
end
