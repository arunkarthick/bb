class LeaguesController < ApplicationController
  active_scaffold :league do |conf|
  	conf.columns = [:year, :name, :divisions]
    conf.actions = [:list]
    list.per_page = DEFAULT_NUMBER_OF_LIST_ITEMS
  end
end
