class ScoreSwap < ApplicationRecord
  belongs_to :match
  delegate :winner, :loser, :round, to: :match


  def self.store_to_file
    File.open("swaps_day_#{Match.current_round}.txt", "w+") do |f|
      all.each do |s|
        f.write(s.pretty + "\n")
      end
    end
  end

  def pretty
    "#{winner.name} swapped #{winner_score} with #{loser_score}  beating #{loser.name}  at round #{round}"
  end
end
