class Guess < ActiveRecord::Base
  attr_accessible :guess, :game
  belongs_to :game
end
