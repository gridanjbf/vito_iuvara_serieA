class Team < ApplicationRecord
  has_many :home_matches
  has_many :away_matches
  has_many :won_matches, foreign_key: :winner_id, class_name: 'Match'

  def self.lookup(name)
    find_by(name: name)
  end
  def tie_matches
    away_matches.where(winner_id: nil).merge(home_matches.where(winner_id: nil))
  end

  def swaps
    Match.where(winner: self, swapping: true)
  end

  def self.vito_rank
    Team.order(score: :desc)
  end

  def self.rank_at(round)
    matches = Match.where("round <= ?", round)
    results = {}
    matches.each do |m|
      if m.winner.present?
        results[m.winner.name] ||= 0
        results[m.winner.name]+=3
      else
        results[m.home.name] ||= 0
        results[m.home.name]+=1
        results[m.away.name] ||= 0
        results[m.away.name]+=1
      end
    end
    results.sort_by { |key, value| value }.reverse
  end
end
