INPUT = File.read("./input.txt")

def part_one(input)
  open   = input.gsub(")", "").length
  closed = input.gsub("(", "").length
  open - closed
end

puts "The solution to part one is"
puts
puts part_one(INPUT)
puts
puts

def part_two(input)
  level = 0
  position = 1
  input.each_char do |char|
    if char == "("
      level += 1
    elsif char == ")"
      level -= 1
    end

    return position if level < 0
    position += 1
  end
end

puts "The solution to part two is"
puts
puts part_two(INPUT)
puts
puts

