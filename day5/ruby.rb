INPUT = File.read "input.txt"


class Runner

  def self.run(*args)
    new(*args).run
  end

  attr_reader :input

  def initialize(arg)
    @input = arg
  end

  def run
    puts
    puts "The answer to part one is"
    puts part_one
    puts
    puts

    puts
    puts "The answer to part two is"
    puts part_two
    puts
    puts
  end

  private

  def part_one
    input.split("\n").map { |str| Word.new(str)}.select{|w| w.nice?}.length
  end

  def part_two
    input.split("\n").map { |str| NicerWord.new(str)}.select{|w| w.nice?}.length
  end

end

class Word
  attr_reader :str

  def initialize(str)
    @str = str
  end

  def nice?
    at_least_three_vowels? &&
    at_least_one_repeat?   &&
    no_banned_strings?
  end


  private

  def at_least_three_vowels?
    str.gsub(/[^aeiou]/, "").length >= 3
  end

  def at_least_one_repeat?
    str =~ /(.)\1/
  end

  def no_banned_strings?
    ! %w(ab cd pq xy).any?{|s| str =~ Regexp.new(s)}
  end
end

class NicerWord < Word
  def nice?
    non_overlapping_repeat? &&
    letter_sandwich?
  end

  private

  def non_overlapping_repeat?
    str =~ /(..).*\1/
  end

  def letter_sandwich?
    str =~ /(.).\1/
  end
end


Runner.run(INPUT)
