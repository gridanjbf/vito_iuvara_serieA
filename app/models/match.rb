class Match < ApplicationRecord
  belongs_to :home
  belongs_to :away
  validates_presence_of :away_score, :home_score, :matchday

  before_save :set_winner


  private

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
