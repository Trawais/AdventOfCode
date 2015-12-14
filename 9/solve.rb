#!/usr/bin/env ruby
def get_city_index(cities, city)
  if cities[city]
    cities[city]
  else
    new_index = cities.length
    cities[city] = new_index
    new_index
  end
end

def learn_cities(lines)
  cities = {}
  lines.each do |line|
    line[/(\w+) to (\w+) = \d+/]
    get_city_index(cities, $1)
    get_city_index(cities, $2)
  end
  cities
end

def generate_road_matrix(cities, size, lines)
  roads_matrix = Array.new(size) { Array.new(size, 0) }
  lines.each do |line|
    line[/(\w+) to (\w+) = (\d+)/]
    first_index = get_city_index(cities, $1)
    second_index = get_city_index(cities, $2)
    roads_matrix[first_index][second_index] = $3.to_i
    roads_matrix[second_index][first_index] = $3.to_i
  end
  roads_matrix
end

def generate_all_routes(size)
  Array(0...size).permutation.to_a
  #reduced = []
  #all_routes.each {|route| reduced << route unless reduced.include?(route.reverse) }
  #reduced
end

lines = File.readlines(ARGV[0])
cities = learn_cities(lines)
size = cities.length
roads_matrix = generate_road_matrix(cities, size, lines)
all_possible_routes = generate_all_routes(size)
to_observe = all_possible_routes.length
shortest_route = Float::INFINITY
longest_route = 0

all_possible_routes.each_with_index do |route, index|
  sum = 0
  for i in (0...route.length-1)
    sum += roads_matrix[route[i]][route[i+1]]
  end
  shortest_route = sum if sum < shortest_route
  longest_route = sum if sum > longest_route
  puts "#{index}/#{to_observe}" if index % 100 == 0
end

puts "shortest route: #{shortest_route}"
puts "longest route: #{longest_route}"
