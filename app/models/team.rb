class Team < ActiveRecord::Base
  attr_accessible :city, :division_id, :name

  has_many :players
  belongs_to :division

  def players_list
  	players.collect {|p| p.given_name + " " + p.surname}.join(", ")
  end

  def total_players
  	players.count
  end

  def league
  	division.league.name
  end

  def division_name
  	division.name
  end
end
