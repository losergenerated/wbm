FactoryGirl.define do
  factory :game do
    after(:build) { |game| game.setup!(Game.default_chars, Game.default_slots) }
  end
end
