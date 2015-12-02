INPUT = File.read("input.txt")

class Array
  def sum
    self.reduce(&:+)
  end
end

class Box
  attr_reader :l, :w, :h

  def initialize(instr)
    @l,@w,@h = instr.split("x").map(&:to_i)
  end

  def sides
    [
      l * w,
      l * h,
      w * h
    ]
  end

  def smallest_side
    sides.min
  end

  def perimeters
    [
      2*l + 2*w,
      2*w + 2*h,
      2*h + 2*l
    ]
  end

  def smallest_perimeter
    perimeters.min
  end

  def volume
    l * w * h
  end

  def paper_needed
    (sides.sum * 2) + smallest_side
  end

  def ribbon_needed
    smallest_perimeter + volume
  end
end

class Runner
  def self.run(*args)
    self.new(*args).run
  end

  def initialize(input)
    @boxes = input.split("\n").map{|b| Box.new(b)}
  end

  def part_one
    @boxes.map(&:paper_needed).sum
  end

  def part_two
    @boxes.map(&:ribbon_needed).sum
  end

  def run
    puts "The solution to part one is"
    puts
    puts part_one
    puts
    puts
    puts "The solution to part two is"
    puts
    puts part_two
    puts
    puts
  end
end

Runner.run(INPUT)
