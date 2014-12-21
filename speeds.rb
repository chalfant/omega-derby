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
  vector.each do |v|
    leg_distance = v * segment_time

    # will race finish on this leg?
    if (d + leg_distance) >= distance
      t += (distance - d) / v.to_f
      return t
    end

    d += leg_distance
    t += segment_time
  end
end

vectors = [
      [16,22,31,16,37],
      [21,22,15,16,48],
      [16,15,13,21,58],
      [15,21,14,28,44],
      [35,17,16,31,23],
      [19,28,33,27,15],
      [30,27,16,29,20],
      [12,33,14,37,26],
      [20,21,19,33,28],
      [31,31,12,35,13],
      [18,29,13,14,49],
      [24,16,21,23,38],
      [13,21,19,17,52],
      [21,19,26,13,44],
      [29,32,24,13,25],
      [21,27,20,26,28],
      [13,28,33,15,33],
      [14,29,32,26,21],
      [28,25,23,20,26],
      [29,19,14,17,44]
    ]

d = 700
segment_time = 6

vectors.each do |v|
  t = race_time(v, d, segment_time)
  puts "#{v.inspect}: #{t.round(1)}"
  1.upto(3) do
    v.shuffle!
    t = race_time(v, d, segment_time)
    puts "#{v.inspect}: #{t.round(1)}"
  end
  puts
end
exit

number_of_speed_changes = 5

# velocity reqd to finish race on time
base_velocity = 25


#
# generate a list of vectors of five velocities
# where the average speed is the base velocity
#
# avg = (v1 + v2 + v3 + v4 + v5)/5
# 5*avg = v1 + v2 + v3 + v4 + v5
#

# pick a number between (0.5*base)..(1.5*base)

vs = []
1.upto(20) do
  sum = number_of_speed_changes * base_velocity
  v = []
  1.upto(number_of_speed_changes-1) do

    pick = (rand()+0.5)*base_velocity

    v << pick.to_i
    sum -= pick
  end
  v << sum.to_i

  vs << v
end

puts JSON.generate(vs)
