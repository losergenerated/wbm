class ApplicationController < ActionController::Base
  protect_from_forgery

  def find_game
    @game = Game.find_by_id(params[:id])
    return render :json => {:error => "Game Not Found"} if @game.nil?
  end
end
