class Team < ApplicationRecord
  has_many :home_matches
  has_many :away_matches
  has_many :won_matches, foreign_key: :winner_id

  def tie_matches
    away_matches.where(winner_id: nil).merge(home_matches.where(winner_id: nil))
  end
end
