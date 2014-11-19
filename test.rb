#!/usr/bin/env ruby

MAX_DISTANCE = 100
SPEEDS = 8
PRNG = Random.new

class Horse
  attr_accessor :name, :distance
  
  def initialize(name)
    @name = name
    @distance = PRNG.rand
    @speeds = []
    1.upto(8) { @speeds << PRNG.rand(8..16) }
  end

  def avg_speed
    @speeds.inject(:+)/SPEEDS.to_f
  end

  def move
    @distance += @speeds[ PRNG.rand(@speeds.size) ] + PRNG.rand
  end
end

def race(horses, distance)
  running = true

  while running do
    horses.each do |h|
      h.move
      if h.distance > MAX_DISTANCE
        running = false
      end
    end
  end
end

def reset(horses)
  horses.map {|h| h.distance = PRNG.rand}
end

def odds(per)
  if per == 0
    return 'N/A'
  end
  (1/per - 1).round(2)
end

i = 0
@horses = [
  Horse.new(i+=1),
  Horse.new(i+=1),
  Horse.new(i+=1),
  Horse.new(i+=1),
  Horse.new(i+=1)
]

results = {
  "1-2" => 0,
  "1-3" => 0,
  "1-4" => 0,
  "1-5" => 0,
  "2-3" => 0,
  "2-4" => 0,
  "2-5" => 0,
  "3-4" => 0,
  "3-5" => 0,
  "4-5" => 0,
}

races = 10000
1.upto(races) do
  race(@horses, MAX_DISTANCE)
  @horses.sort_by! { |h| -h.distance }
  top_two = @horses.take(2).sort_by! {|h| h.name}
  results["#{top_two[0].name}-#{top_two[1].name}"] += 1
  reset(@horses)
end

sum = 0
results.each do |k,v|
  sum += v
  puts "#{k}: #{(v/races.to_f).round(2)} #{odds(v/races.to_f)}"
end

puts "#{sum}"

