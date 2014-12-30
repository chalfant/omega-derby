#!/usr/bin/env ruby
require 'json'

# TODO
# * given a set of vectors:
# ** output a list of position changes
# ** output how "close" the end is
# *** avg distance between leader and each other horse?
# ** output how many times the leader changes
# ** output if this is a "come from behind win"

# Basically we want to measure a set of vectors (a race)
# and determine how "exciting" it is.

def race_time(vector, distance, segment_time)
  # d = v/t
  d = 0
  t = 0

  v_index = 0
  while d < distance
    v = vector[v_index]
    v = vector.last if v.nil?

    v_index += 1
    leg_distance = v * segment_time

    # will race finish on this leg?
    if (d + leg_distance) >= distance
      t += (distance - d) / v.to_f
      return t
    end

    d += leg_distance
    t += segment_time
    #puts "d: #{d}, t: #{t}"
  end
end

vs = []

data = []
File.open(ARGV.shift) do |file|
  file.each do |line|
    data << line.chomp.to_f
  end
end

1.upto(20) do
  v = []

  1.upto(5) do
    v << data.sample
  end

  v << race_time(v, 1.0, 0.2)
  vs << v
end

#puts JSON.generate(vs.sample(5).sort_by { |e| e.last  })
puts JSON.generate(vs)
