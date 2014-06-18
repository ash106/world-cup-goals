class GamesController < ApplicationController
  def goals
    render :json => { goals: Game.get_all_goals }
  end
end
