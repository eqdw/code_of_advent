INPUT = File.read "input.txt"

class Runner
  def self.run(*args)
    new(*args).run
  end

  def initialize(input)
    @input = input
  end

  def run
    puts "Part one:"
    puts part_one
    puts "Part two:"
    puts part_two
  end

  private

  def part_one
    recipe = Recipe.new(@input)#.high_score
    recipe.high_score
  end

  def part_two

  end
end

class Recipe
  attr_reader :ingredients

  def initialize(input)
    @ingredients = []
    input.each_line { |line| @ingredients << Ingredient.new(line) }
  end

  def high_score
    score = 0
    (0..100).each do |i|
      (0..100).each do |j|
        if i+j <= 100
          (0..100).each do |k|
            if i+j+k <= 100
              (0..100).each do |l|
                if i+j+k+l <= 100
                  proportion = {
                    ingredients[0] => i,
                    ingredients[1] => j,
                    ingredients[2] => k,
                    ingredients[3] => l
                  }
                  total = score(proportion)
                  if total > score
                    score = total
                  end
                end
              end
            end
          end
        end
      end
    end

    score
  end

  def score(ingredients)
    values = {
      :capacity   => 0,
      :durability => 0,
      :flavour    => 0,
      :texture    => 0,
      :calories   => 0
    }

    ingredients.each do |k,v|
      values[ :capacity   ] += (k.capacity   * v)
      values[ :durability ] += (k.durability * v)
      values[ :flavour    ] += (k.flavour    * v)
      values[ :texture    ] += (k.texture    * v)
      values[ :calories   ] += (k.calories   * v)
    end


    return 0 if values.values.any? {|n| n <= 0}
    return 0 unless values[:calories] == 500

    values[:calories] = 1 #cheating to make reduce(:*) work
    return values.values.reduce(:*)
  end
end

class Ingredient
  attr_reader :name, :capacity, :durability, :flavour, :texture, :calories

  def initialize(line)
    data = line.split(/\s/)

    @name       = data[ 0].gsub(",", "")
    @capacity   = data[ 2].to_i
    @durability = data[ 4].to_i
    @flavour    = data[ 6].to_i
    @texture    = data[ 8].to_i
    @calories   = data[10].to_i
  end
end

Runner.run(INPUT)
