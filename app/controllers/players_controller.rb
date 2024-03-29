class PlayersController < ApplicationController
  active_scaffold :player do |conf|
    conf.columns = [:league, :division, :given_name, :surname, :team, :average, :hr, :rbi, :runs, :sb, :ops]
    list.sorting = {:average => 'DESC NULLS LAST'}
    conf.actions = [:list]
    list.per_page = DEFAULT_NUMBER_OF_LIST_ITEMS
    conf.columns[:hr].label = "HR"
    conf.columns[:rbi].label = "RBI"
    conf.columns[:sb].label = "SB"
    conf.columns[:ops].label = "OPS"
    conf.action_links.add 'index', :label => 'Import',  :page => true, :controller => "import"
  end
end
