class Match < ApplicationRecord
  belongs_to :home, class_name: 'Team'
  belongs_to :away, class_name: 'Team'
  belongs_to :winner, class_name: 'Team', optional: true
  has_one :score_swap
  validates_presence_of :away_score, :home_score

  before_save :set_winner

  def self.current_round
    Match.maximum(:round)
  end

  def loser
    return nil unless winner
    winner == home ? away : home
  end

  def assign_points
    update_scores
    check_vito_rule
  end

  def home=(value)
    val = if (value.is_a? String)
      team = Team.find_by(name: value)
      team
    else
      value
    end
    super(val)
  end

  def pretty
    "#{round} #{home.name} #{home_score} - #{away_score} #{away.name}"
  end

  def away=(value)
    val = if (value.is_a? String)
      Team.find_by(name: value)
    else
      value
    end
    super(val)
  end

  private

  # facilitate insertion via console

  def update_scores
    if winner.nil?
      home.score+=1
      away.score+=1
      home.save
      away.save
    else
      winner.score+=3
      winner.save
    end
  end

  def vitoable?
   winner && (winner.score < loser.score)
  end

  def vitofy
    winner.swap_score(self.id, loser, track_swap: true)
  end

  def check_vito_rule
    vitofy if vitoable?
  end

  def set_winner
    self.winner_id = if away_score > home_score
      away_id
    elsif home_score > away_score
      home_id
    else
      nil
    end
  end
end
