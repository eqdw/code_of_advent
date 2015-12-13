INPUT = File.read "input.txt"

class Seating
  def initialize(input)
    @guest_preferences = {}
    parse_guests(input)
  end

  def guests
    @guest_preferences.keys.sort
  end

  def optimal
    guests.permutation.map{|list| total_utility(list)}.max
  end

  def total_utility(list)
    total = 0
    list.length.times do |i|
      g1 = list[i]
      g2 = list[ (i+1) % list.length ]

      total += pair_utility(g1,g2)
    end
    total
  end

  def pair_utility(g1, g2)
    @guest_preferences[g1][g2] + @guest_preferences[g2][g1]
  end

  private

  def parse_guests(input)
    input.each_line do |line|
      data = line.split " "
      guest  = data[0]
      sign   = (data[2] == "gain") ? 1 : -1
      val    = data[3].to_i * sign
      target = data[-1].gsub(".", "")

      @guest_preferences[guest] ||= {}
      @guest_preferences[guest][target] = val
    end
  end
end

class SelfSeating < Seating

  def initialize(input)
    super(input)

    @guest_preferences["eqdw"] = {}

    guests.each do |guest|
      @guest_preferences[guest]["eqdw"] = 0
      @guest_preferences["eqdw"][guest] = 0
    end
  end
end
