INPUT = File.read "input.txt"

class Runner
  def self.run(*args)
    new(*args).run
  end

  def initialize(input)
    @input = input
  end

  def run
    puts "Part One:"
    puts part_one
    puts
    puts "Part Two:"
    puts part_two
  end

  private

  def part_one
    MedicineMachine.new(@input).find_all_variants.length

  end

  def part_two

  end
end

class MedicineMachine

  def initialize(input)
    @rules = {}

    input.each_line do |line|

      if /=/ =~ line
        data = line.split " "

        @rules[data[0]] ||= []
        @rules[data[0]] << data[2]
      else
        @molecule = []
        line.each_char do |chr|
          if /[A-Z]/ =~ chr
            @molecule << chr
          elsif /[a-z]/ =~ chr
            @molecule[-1] << chr
          end
        end
      end
    end
  end

  def find_all_variants
    variants = []
    @rules.each do |target, replace_rules|
      replace_rules.each do |replace|
        variants += find_variants(target, replace)
      end
    end

    variants.uniq
  end

  def find_variants(target, replace)
    variants = []

    @molecule.each_with_index do |atom, i|
      if atom == target
        puts "DEBUG: applying #{target} => #{replace} at loc #{i}"
        _mole = @molecule.clone
        _mole[i] = replace
        variants << _mole.join("")
      end
    end


    puts "DEBUG: target #{target} found #{variants.length} times"

    variants.uniq
  end

  def find_recipe
    backwards = {}

  end
end

Runner.run(INPUT)
