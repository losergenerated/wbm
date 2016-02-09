require 'spec_helper'

describe GameController, type: :controller do

  describe '#show' do
    before :each do
      @game = FactoryGirl.create :game
    end

    it 'should ' do
      get "show", :id => @game.id
      expect(response.status).to eq(200)
    end
  end
end
