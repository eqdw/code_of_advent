require 'digest'

INPUT = File.read("input.txt")

class Runner
  def self.run(*args)
    new(*args).run
  end

  attr_reader :key

  def initialize(key)
    @key = key
  end

  def run
    puts
    puts 'The solution to part one is'
    puts part_one
    puts
    puts

    puts
    puts 'The solution to part two is'
    puts part_two
    puts
    puts
  end

  private

  def solve(match)
    i = 0

    while
      input = "#{key}#{i}"
      md5 = Digest::MD5.hexdigest(input)
      if md5 =~ match
        return i
      end
      i += 1
    end

  end

  def part_one
    solve(/^00000/)
  end

  def part_two
    solve(/^000000/)
  end
end

Runner.run(INPUT)
