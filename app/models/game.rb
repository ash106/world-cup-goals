class Game < ActiveRecord::Base
  validates :year, :pos, :goals, presence: true
end
