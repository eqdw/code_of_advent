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
    puts "The solution to part one:"
    puts part_one
    puts

    puts
    puts "The solution to part two:"
    puts part_two
    puts
  end

  private

  def part_one
    circuit = Circuit.new(input)

    circuit.value_of "a"
  end

  def part_two
    circuit = Pt2Circuit.new(input)

    circuit.value_of "a"
  end
end

class Circuit
  attr_reader :wires

  def initialize(list_of_wires)
    @wires = {}

    list_of_wires.each_line do |line|
      add_wire(line)
    end
  end

  def add_wire(str)
    tokens = str.split " "

    wire = case tokens.length
    when 3 # 123 -> a,   b -> a
      Value.new(tokens.first, self)
    when 4 # NOT x -> y
      Not.new(tokens[1], self)
    when 5
      Gate.new(tokens, self)
    end

    wires[tokens.last] = wire
  end

  def value_of(wire)
    puts "DEBUG: looking up #{wire}"
    wires[wire].value
  end
end

class Pt2Circuit < Circuit
  def value_of(wire)
    if wire == "b"
      puts "DEBUG: part 2 override"
      16076
    else
      super(wire)
    end
  end
end

class Wire
  attr_reader :circuit

  def initialize(input, circuit)
    @input   = input
    @circuit = circuit
  end

  def lookup(wire)
    if wire =~ /\d+/
      wire.to_i
    else
      circuit.value_of(wire)
    end
  end
end

class Value < Wire
  def value
    @value ||= if @input.is_a? Numeric
                 @input
               else
                 lookup(@input)
               end
  end
end

class Not < Wire
  def value
    @value ||= ( ~ lookup(@input) )
  end
end

class Gate < Wire
  attr_reader :inputs, :operation

  def initialize(spec, circuit)
    @circuit = circuit
    @inputs = [spec[0], spec[2]]
    @operation = spec[1].downcase
  end

  def value
    @value ||= begin
      x = lookup(inputs.first)
      y = lookup(inputs.last)
      operate(x,y)
    end
  end

  def operate(x,y)
    case operation
    when "and"
      x & y
    when "or"
      x | y
    when "rshift"
      x >> y
    when "lshift"
      x << y
    end
  end
end

Runner.run(INPUT)
