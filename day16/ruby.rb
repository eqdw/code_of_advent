class Sue
  def initialize(input)
    data = input.split " "

    @id = data[1].to_i

    @traits = {}
    @traits[ data[2].gsub(":", "").to_sym ] = data[3].to_i
    @traits[ data[4].gsub(":", "").to_sym ] = data[5].to_i
    @traits[ data[6].gsub(":", "").to_sym ] = data[7].to_i
  end

  [:children, :cats, :samoyeds, :pomeranians, :akitas,
   :vizslas, :goldfish, :trees, :cars, :perfumes].each do |trait|
    puts "defining #{trait}"
    define_method(trait) do
      @traits[trait]
    end
  end
end

class SueFinder
  attr_reader :sues

  def initialize(input)
    @sues = []
    input.each_line {|line| @sues << Sue.new(line)}
  end

  def find(traits)
    candidates = sues
    traits.each do |k,v|
      if k == :cats || k == :trees
        candidates = candidates.select{|sue| sue.send(k) == nil || sue.send(k) > v}
      elsif k == :pomeranians || k == :goldfish
        candidates = candidates.select{|sue| sue.send(k) == nil || sue.send(k) < v}
      else
        candidates = candidates.select{|sue| sue.send(k) == nil || sue.send(k) == v}
      end
    end
    candidates.first
  end
end

TO_FIND = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}
