class GameController < ApplicationController
  before_filter :find_game, :only => [:cheat, :show]
  def create 
    game = Game.new
    chars = params[:chars].try(:split, "") || Game.default_chars
    slots = params[:slots]                 || Game.default_slots
    slots = slots.to_i

    game.setup!(chars, slots)
    return render :json => {:game => game.id, 
                            :charset => game.charset, 
                            :slots => game.guess_slots}
  end

  def cheat
    @game.update_attribute(:active, true) if params[:active]
    return render :json => {:game => @game.id, :answer => @game.answer}
  end

  def show
    return render :json => {:game => @game.id,
                            :active => @game.active?,
                            :num_guesses => @game.num_guesses,
                            :guesses => @game.guesses.collect(&:guess),
                            :charset => @game.charset.to_s, 
                            :slots => @game.guess_slots}
  end

end
