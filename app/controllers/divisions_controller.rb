class DivisionsController < ApplicationController
  active_scaffold :division do |conf|
    conf.actions = [:list]
    list.per_page = DEFAULT_NUMBER_OF_LIST_ITEMS
  end
end
