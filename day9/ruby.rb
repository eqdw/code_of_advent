INPUT = File.read "input.txt"

class Runner
  def self.run(*args)
    new(*args).run
  end

  attr_reader :map
  def initialize(input)
    @map = Brüt.new(input)
  end

  def run
    puts "The solution to part one:"
    puts part_one
    puts
    puts "The solution to part two:"
    puts part_two
    puts
  end

  private

  def part_one
    @map.all_paths_naieve
  end

  def part_two
    @map.all_paths_naieve(:longest)
  end
end

class Brüt

  INFINITY = 1/0.0

  def initialize(input)
    @routes = {}
    @memo = {}
    input.each_line {|line| add_route(line) }
  end

  def distance(from, to)
    @routes[from][to]
  end

  def nodes
    @routes.keys
  end

  def all_paths_naieve(goal=:shortest)
    paths = nodes.permutation

    comparator = ->(x, y) do
      case goal
      when :shortest
        x < y
      when :longest
        x > y
      end
    end

    current_best = if goal == :shortest
                     INFINITY
                   else
                     0
                   end

    paths.size.times do
      path = paths.next
      dist = path_distance(path)
      if comparator.call(dist, current_best)
        current_best = dist
      end
    end

    current_best
  end


  def path_distance(stops)
    interruptable_path_distance(stops, INFINITY)
  end

  def interruptable_path_distance(stops, threshold)
    dist = 0
    (stops.length-1).times do |i|
      from = stops[i]
      to   = stops[i+1]

      dist += distance(from, to)
      return nil if dist > threshold
    end

    dist
  end


  private

  def add_route(line)
    data = line.split " "

    from = data[0]
    to   = data[2]
    dist = data[4].to_i

    @routes[ from ] ||= {}
    @routes[ to   ] ||= {}

    @routes[ from ][ to   ] = dist
    @routes[ to   ][ from ] = dist
  end
end

Runner.run(INPUT)
