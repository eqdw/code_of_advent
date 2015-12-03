INPUT = File.read("input.txt")

class Runner
  def self.run(*params)
    self.new(*params).run
  end

  attr_reader :input

  def initialize(_input)
    @input = _input
  end

  def run
    puts
    puts "The solution to part one is:"
    puts part_one
    puts
    puts

    puts
    puts "The solution to part two is:"
    puts part_two
    puts
    puts
  end

  private

  def part_one
    map = Map.new(1)

    input.each_char do |chr|
      map.walk(chr)
    end

    map.houses_visited.length
  end

  def part_two
    map = Map.new(2)

    input.each_char do |chr|
      map.walk(chr)
    end


    map.houses_visited.length
  end
end

class Coordinate
  attr_reader :x, :y

  def to_s
    "(#{x}, #{y})"
  end

  def initialize(x,y)
    @x, @y = x,y
  end

  def <=>(other)
    self.x == other.x && self.y == other.y
  end

  def to_tuple
    [x,y]
  end

  def up
    Coordinate.new(x, y+1)
  end

  def down
    Coordinate.new(x, y-1)
  end

  def left
    Coordinate.new(x-1, y)
  end

  def right
    Coordinate.new(x+1, y)
  end

  def dup
    Coordinate.new(x, y)
  end
end

class Santa
  attr_reader :current, :path

  def initialize
    @current = Coordinate.new(0,0)
    @path    = [current.dup]
  end

  def walk(cmd)
    case cmd
    when "^"
      update_current current.up
    when "v"
      update_current current.down
    when "<"
      update_current current.left
    when ">"
      update_current current.right
    end

    update_path(current)
  end

  def houses_visited
    @path.uniq(&:to_tuple)
  end

  private

  def update_current(coord)
    @current = coord
  end

  def update_path(coord)
    @path.push(coord)
  end
end

class Map

  attr_reader :santas, :current_santa

  def initialize(santa_count=1)
    @santas = []
    santa_count.times { santas << Santa.new }

    @current_santa = 0
  end

  def walk(chr)
    santa = santas[current_santa]

    santa.walk(chr)

    @current_santa = (current_santa + 1) % santas.length
  end

  def houses_visited
    santas.reduce([]){|acc, santa| acc + santa.houses_visited}.uniq(&:to_tuple)
  end
end

Runner.run(INPUT)
