INPUT = "vzbxkghb"


class Password
  INCREASING_STRAIGHTS = ("a".."x").map{|x| "#{x}#{x.succ}#{x.succ.succ}"}
  PAIRS = ("a".."z").map{|x| x*2}


  attr_reader :password

  def initialize(pw)
    @password = pw
  end


  def next_password
    next_pass = password

    loop do
      next_pass.succ!
      break if valid?(next_pass)
    end

    Password.new(next_pass)
  end

  def valid?(pw)
    increasing_straight?(pw)  &&
    no_banned_letters?(pw)    &&
    two_nonoverlapping_pairs?(pw)
  end

  private

  def increasing_straight?(pw)
    INCREASING_STRAIGHTS.any? do |straight|
      pw.include? straight
    end
  end

  def no_banned_letters?(pw)
    ! (pw =~ /[iol]/)
  end

  def two_nonoverlapping_pairs?(pw)
    count = 0
    PAIRS.each do |pair|
      count += 1 if pw.include? pair
    end

    count >= 2
  end
end

