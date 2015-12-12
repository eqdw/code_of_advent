require 'json'
INPUT = JSON.parse File.read "input.txt"

# invokes block on every json leaf
def walk_json(jsonish, guard=nil, &block)
  return if guard && guard.call(jsonish)

  case jsonish
  when Hash
    jsonish.values.each{|val| walk_json(val, guard, &block)}
  when Array
    jsonish.each{|val| walk_json(val, guard, &block)}
  else
    yield jsonish
  end
end

def count_numbers(input)
  total = 0
  walk_json(input) do |val|
    if val.is_a? Numeric
      total += val
    end
  end
  total
end

def count_avoiding_red(input)
  redcheck = ->(to_check) do
    if to_check.is_a? Hash

      if to_check.values.any?{|val| val == "red"}
        true
      else
        false
      end
    else
      false
    end
  end

  total = 0
  walk_json(input, redcheck) do |val|
    if val.is_a? Numeric
      total += val
    end
  end
  total
end
