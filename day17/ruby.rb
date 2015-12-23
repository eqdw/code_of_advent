class Containers
  def initialize(input)
    @containers = []
    input.each_line {|line| @containers << line.to_i}
  end

  def combos(n)
    valid = []

    (1..@containers.length).each do |i|
      valid += @containers.combination(i).find_all {|conts| conts.reduce(:+) == n}
    end

    valid
  end

  def smallest_by_amount(n)
    combos = combos(n)

    counts = {}

    combos.each do |comb|
      counts[comb.length] ||= 0
      counts[comb.length] += 1
    end

    smallest = counts.keys.min
    counts[smallest]
  end
end
