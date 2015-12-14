INPUT = File.read "input.txt"

class Reindeer
  attr_reader :name, :speed, :duration, :rest, :distance


  ALLOWED_STATUS = [:flying, :resting]

  def initialize(str)
    data = str.split " "
    @name     = data[  0 ]
    @speed    = data[  3 ].to_i
    @duration = data[  6 ].to_i
    @rest     = data[ 13 ].to_i

    @status   = :flying
    @for      = 0
    @distance = 0
  end

  def update!
    self.send("update_#{@status}!")
  end

  private

  def update_flying!
    @for      += 1
    @distance += speed

    if duration == @for
      @status = :resting
      @for = 0
    end
  end

  def update_resting!
    @for += 1

    if rest == @for
      @status = :flying
      @for = 0
    end
  end
end

class Race
  def initialize(input)
    @reindeers = []

    input.each_line{|line| @reindeers << Reindeer.new(line)}
  end

  def race!(seconds)
    seconds.times { update! }

    @reindeers.sort_by(&:distance).reverse.each do |r|
      puts "#{r.name} has travelled #{r.distance}"
    end
  end

  def update!
    @reindeers.each(&:update!)
  end
end

class PointedRace < Race

  def initialize(input)
    super(input)

    @points = {}

    @reindeers.each{|r| @points[r] = 0}
  end

  def race!(seconds)
    seconds.times{ update! }

    @points.values.sort.reverse
  end

  def update!
    super

    assign_points!
  end

  def current_lead
    @reindeers.map(&:distance).max
  end

  def reindeer_in_lead
    @reindeers.select{|r| r.distance == current_lead}
  end

  private

  def assign_points!
    reindeer_in_lead.each { |r| @points[r] += 1 }
  end
end
