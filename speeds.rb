#!/usr/bin/env ruby
require 'json'

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
