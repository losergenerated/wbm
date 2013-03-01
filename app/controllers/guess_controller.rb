class GuessController < ApplicationController
  before_filter :find_game, :only => [:guess]
  def guess
    return render :json => {:error => "Game is over"} unless @game.active?
    result = @game.guess!(params[:guess])

    return render :json => {:game => @game.id, 
                            :result => result, 
                            :active => @game.active?, 
                            :guess => params[:guess], 
                            :num_guesses => @game.num_guesses}
  end

end
