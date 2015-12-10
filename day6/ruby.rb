INPUT = File.read("input.txt")

class Runner
  def self.run(*args)
    new(*args).run
  end

  attr_reader :input

  def initialize(_input)
    @input = _input
  end

  def run
    puts
    puts "The solution to part one is"
    puts part_one
    puts
    puts

    puts
    puts "The solution to part two is"
    puts part_two
    puts
    puts
  end

  private

  def part_one
    lights = Lights.new(1000)
    input.each_line do |line|
      lights.operation(line)
    end

    lights.count_lights
  end

  def part_two
    lights = BrightLights.new(1000)
    input.each_line do |line|
      lights.operation(line)
    end

    lights.count_lights
  end
end

class Lights
  attr_reader :map

  def initialize(size)
    @map = Array.new(size) { Array.new(size){false} }
  end

  def operation(op)
    puts "running #{op}"
    op = op.split(" ").reject{|s| s == "turn"}.reject{|s| s == "through"}

    action = op.shift
    bounds = op.map{|o| o.split(",")}.flatten.map(&:to_i)
    change_block(bounds, action)
  end

  def on(x,y)
    map[x][y] = true
  end

  def off(x,y)
    map[x][y] = false
  end

  def toggle(x,y)
    map[x][y] = !map[x][y]
  end

  def change_block(bounds, action)
    x1,y1,x2,y2 = bounds
    x1.upto(x2) do |x|
      y1.upto(y2) do |y|
        self.send(action, x, y)
      end
    end
  end

  def block_on(corners)
    change_block(corners, :on)
  end

  def block_off(corners)
    change_block(corners, :off)
  end

  def block_toggle(corners)
    change_block(corners, :toggle)
  end

  def count_lights
    map.map{|row| row.select{|l| l == true}.length}.reduce(&:+)
  end
end

class BrightLights < Lights

  def initialize(size)
    @map = Array.new(size){ Array.new(size) { 0 } }
  end

  def on(x,y)
    map[x][y] += 1
  end

  def off(x,y)
    if map[x][y] > 0
      map[x][y] -= 1
    end
  end

  def toggle(x,y)
    map[x][y] += 2
  end

  def count_lights
    map.flatten.reduce(&:+)
  end
end

Runner.run(INPUT)
