class Game < ActiveRecord::Base
  validates :year, :pos, :goals, presence: true

  ALL_YEARS = (1930..2014).step(4).to_a - [1942, 1946]

  class << self
    def destroy_all_games(year = nil)
      if year.present?
        where(year: year)
      else
        all
      end.destroy_all
    end

    def create_all_games
      ALL_YEARS.each do |year|
        create_world_cup_games_by_year(year)
      end
    end

    def create_world_cup_games_by_year(year)
      puts "do #{year} stuff here!"
      pos = 1
      res = Net::HTTP.get_response(URI("http://blooming-sands-8526.herokuapp.com/event/world.#{year}/rounds"))
      rounds_data = JSON.parse(res.body)
      rounds = rounds_data["rounds"].count
      rounds.times do |round|
        res = Net::HTTP.get_response(URI("http://blooming-sands-8526.herokuapp.com/event/world.#{year}/round/#{round + 1}"))
        round_data = JSON.parse(res.body)
        round_data["games"].each do |game|
          if game["score1ot"].present? || game["score2ot"].present?
            goals = game["score1ot"].to_i + game["score2ot"].to_i
          else
            goals = game["score1"].to_i + game["score2"].to_i
          end
          Game.create(year: year, pos: pos, goals: goals)
          pos += 1
        end
      end
    end
    handle_asynchronously :create_world_cup_games_by_year
  end
end
