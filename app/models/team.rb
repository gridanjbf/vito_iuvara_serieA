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
    ScoreSwap.select { |swap| swap.loser.id == id || swap.winner.id == id }
  end

  def self.rank_at(round, vitofy: false)
    matches = Match.where("round <= ?", round)
    results = {}
    matches.each do |m|
      if m.winner.present?
        results[m.winner.name] ||= 0
        results[m.winner.name]+=3
        if vitofy && m.score_swap.present?
          results[m.loser.name] = m.score_swap.winner_score
          results[m.winner.name] = m.score_swap.loser_score
        end
      else
        results[m.home.name] ||= 0
        results[m.home.name]+=1
        results[m.away.name] ||= 0
        results[m.away.name]+=1
      end
    end
    results.sort_by { |key, value| value }.reverse
  end

  def swap_score(match_id, loser, track_swap: false)
    wscore = self.score
    lscore = loser.score
    self.class.transaction do
      loser.update_column(:score, wscore)
      self.update_column(:score, lscore)
    end

    ScoreSwap.create(match_id: match_id,  loser_score: lscore, winner_score: wscore) if track_swap



  end
end
