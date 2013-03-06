class Player < ActiveRecord::Base
  attr_accessible :average, :given_name, :hr, :ops, :rbi, :runs, :sb, :surname, :team_id

  belongs_to :team

  def league
  	team.division.league.name
  end

  def division
  	team.division.name
  end

  def self.calculate_average(player_xml_data)
    return nil if self.parse_at_bats(player_xml_data) == 0.0
    avg = (self.parse_hits(player_xml_data)/self.parse_at_bats(player_xml_data))
  	avg.nan? ? nil : avg
  end

  def self.calculate_ops(player_xml_data)
    if ((self.calculate_obp(player_xml_data)) + (self.calculate_base_score(player_xml_data) / self.parse_at_bats(player_xml_data))).nan?
      nil
    else
      (self.calculate_obp(player_xml_data) + (self.calculate_base_score(player_xml_data) / self.parse_at_bats(player_xml_data))).to_s
    end

  end

  def self.calculate_base_score(player_xml_data)
  	self.parse_hits(player_xml_data) + self.parse_shut_outs(player_xml_data) + self.parse_era(player_xml_data) + self.parse_home_runs(player_xml_data)
  end

  def self.calculate_obp(player_xml_data)
  	(self.parse_hits(player_xml_data) + self.parse_walks(player_xml_data) + self.parse_hbp(player_xml_data)) / (self.parse_at_bats(player_xml_data) + self.parse_walks(player_xml_data) + self.parse_sacrifice_hits(player_xml_data))
  end

  private

  def self.parse_at_bats(player_xml_data)
    player_xml_data.AT_BATS.text.to_f rescue 0.0
  end

  def self.parse_hits(player_xml_data)
    player_xml_data.HITS.text.to_f rescue 0.0
  end

  def self.parse_home_runs(player_xml_data)
    player_xml_data.HOME_RUNS.text.to_f rescue 0.0
  end

  def self.parse_shut_outs(player_xml_data)
    player_xml_data.SHUT_OUTS.text.to_f rescue 0.0
  end

  def self.parse_era(player_xml_data)
    player_xml_data.ERA.text.to_f rescue 0.0
  end

  def self.parse_sacrifice_hits(player_xml_data)
    player_xml_data.SACRIFICE_HITS.text.to_f rescue 0.0
  end

  def self.parse_walks(player_xml_data)
    player_xml_data.WALKS.text.to_f rescue 0.0
  end

  def self.parse_hbp(player_xml_data)
    player_xml_data.HIT_BY_PITCH.text.to_f rescue 0.0
  end  

end
