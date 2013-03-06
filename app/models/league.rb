class League < ActiveRecord::Base
  attr_accessible :name, :year

  has_many :divisions
end
