INPUT = "3113322113"

def split(input)
  tmp = input.split ""

  rtn = []

  current_digit = nil

  tmp.each do |digit|
    if digit == current_digit
      rtn[-1] += digit
    else
      current_digit = digit
      rtn.push digit
    end
  end
  rtn
end

def count(digits)
  digits.length.to_s
end

def numeral(digits)
  digits[0]
end


def iterate(input)
  split(input).map do |digits|
    count(digits) + numeral(digits)
  end.join
end

cur = INPUT
40.times{ cur = iterate(cur) }
puts "Part one: #{cur.length}"

10.times{cur = iterate(cur) }
puts "Part two: #{cur.length}"

