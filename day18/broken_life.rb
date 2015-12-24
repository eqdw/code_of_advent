infile = ARGV[0]
@gridsize = ARGV[1].to_i


@world = Array.new(@gridsize+2){|i| Array.new(@gridsize+2){"."}}

File.open(infile, "r") do |f|
  (1..@gridsize).each do |i|
    row = f.gets
    rowarr = row.split("")
    (0..@gridsize-1).each do |j|
      @world[i][j+1] = rowarr[j]
    end
  end
end

def num_neighbours(i, j)
  count = 0
  (i-1..i+1).each do |a|
    (j-1..j+1).each do |b|
      unless (i == a) && (j == b)
        count += 1 if @world[a][b] == "#"
      end
    end
  end
  count
end

def render()
  line = ""
  (1..@world.length-2).each do |i|
    line = ""
    (1..@world[i].length-2).each do |j|
      line += "#{@world[i][j]}"
    end
    puts line
  end
end




def tick()
  new_world =  Array.new(@gridsize+2){|i| Array.new(@gridsize+2){"."}}

  (1..@gridsize).each do |i|
    (1..@gridsize).each do |j|
      tmp = num_neighbours(i,j)
      require 'pry';binding.pry unless $skip
      if (i == 1   && j == 1   ||
          i == 100 && j == 100 ||
          i == 1   && j == 100 ||
          i == 100 && j == 1)
        new_world[i][j] = "#"
      elsif(tmp < 2)
        new_world[i][j] = "."
      elsif(tmp > 3)
        new_world[i][j] = "."
      elsif(tmp == 3)
        new_world[i][j] = "#"
      else #if tmp == 2
        if @world[i][j] == "#"
          new_world[i][j] = "#"
        else
          new_world[i][j] = "."
        end
      end

    end
  end
  @world = new_world.clone
end


render
100.times do |i|
  #puts "-" * ( 2 * @gridsize - 1)
  tick
  puts "\n"*25
  render
end

count =  @world.reduce(0) do |acc, row|
  acc + row.reduce(0) { |acc, chr| chr == "#" ? acc+1 : acc}
end
require 'pry';binding.pry
puts count
