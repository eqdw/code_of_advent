input = File.read("input.txt")

code_length = input.split("\n").join("").length

string_length = 0

input.each_line do |line|
  string_length += eval(line).length
end

puts "Part one: #{code_length - string_length}"


encoded = 0

def encoded_char(char)
  puts "DEBUG: checking length of #{char}"
  case char
  when '\\', '"'
    puts "DEBUG: len is 2"
    2
  when "\n"
    0
  else
    puts "DEBUG: len is 1"
    1
  end
end

def encoded_string(str)
  puts "DEBUG: encoded length of << #{str} >>"
  enclen = 2 + str.split("").map{|c| encoded_char(c)}.reduce(&:+)
  puts "DEBUG: #{enclen}"
  enclen
end


input.each_line do |line|
  encoded += encoded_string(line)
end

puts "Part two: #{encoded - code_length}"
