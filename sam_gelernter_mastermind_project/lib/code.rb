require "byebug"

class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(charray)
    charray.all? {|char| POSSIBLE_PEGS.keys.include?(char.upcase) }
  end

  def initialize(charray)
      if !Code.valid_pegs?(charray)
        raise "Whoa partner, them's not valid pegs!"
      else
        @pegs = charray.map {|char| char.upcase}
      end
  end

  attr_reader :pegs

  def self.random(num)
    random_pegs = []
    while random_pegs.length < num 
      possibilities = POSSIBLE_PEGS.length
      options = POSSIBLE_PEGS.keys
      random_pegs << options[rand(0...possibilities)]
    end
    Code.new(random_pegs)
  end

  def self.from_string(pegs)
    colors = pegs.split("")
    Code.new(colors)
  end

  def [](idx)
    pegs[idx]
  end

  def length
    pegs.length
  end

  def num_exact_matches(guess_code)
    guess_code
              .pegs
              .each
              .with_index
              .count { |guess_peg, i| guess_peg == @pegs[i]}
  end

  def num_near_matches(guess_code)
    colors = Hash.new(0)
    correct_colors = 0
    @pegs.each { |peg| colors[peg] += 1 }
    colors.each do |color, num|
      guess_code.pegs.each do |guess_peg|
        if guess_peg == color && colors[guess_peg] > 0
          colors[guess_peg] -= 1
          correct_colors += 1
        end
      end
    end
    correct_colors - num_exact_matches(guess_code)
  end

  def ==(code)
    code.pegs == @pegs
  end
end

