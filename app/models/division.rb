class Division < ActiveRecord::Base
  attr_accessible :league_id, :name

  has_many :teams
  belongs_to :league
end
