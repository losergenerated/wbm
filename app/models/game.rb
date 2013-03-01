class Game < ActiveRecord::Base
  attr_accessible :answer, :active, :guess_slots
  has_many :guesses

  def self.default_chars
    return ["r", "w", "b", "g"]
  end

  def self.default_slots
    return 4
  end

  def setup!(chars, slots)
    self.answer = ""
    sample_method = determine_sample_method
    slots.times do 
      self.answer << chars.send(sample_method)
    end
    self.charset = chars.to_s
    self.guess_slots = slots
    self.active = true
    self.save!
    return self
  end

  def guess!(guess)
    local_guess = Guess.create!(:guess => guess, :game => self)
    check_guess(local_guess)
  end

  def num_guesses
    return guesses.count
  end

private
  def check_state(res)
    game_over = true
    res.each do |el|
      game_over = false unless el == "2"
    end
    return game_over
  end

  def check_guess(guess)
    res = []
    guess_slots.to_i.times { res << '0' }
    ans = {}
    self.answer.split("").each_with_index {|el, i| ans[i] = {:el => el, :used => false} }

    guess_arr = guess.guess.split("")

    check_exact_match(guess_arr, ans, res)
    check_fuzzy_match(guess_arr, ans, res)

    self.update_attribute(:active, false) if check_state(res)
    return res.shuffle
  end

  def check_exact_match(guess_arr, ans, res)
    guess_arr.each_with_index do |el, i|
      if ans[i][:el] == el
        res[i] = '2'
        ans[i][:used] = true
      end
    end
    return res
  end

  def check_fuzzy_match(guess_arr, ans, res)
    guess_arr.each_with_index do |el, i|
      ans.each do |ans_el, used|
        res[i] = '1' if !used && ans_el == el
        ans[i][:used] = true
      end
    end
    return res
  end

  #Ruby 1.9 / 1.8.7 difference...
  def determine_sample_method
    if [].respond_to?(:sample)
      return :sample
    else
      return :choice
    end
  end
end
