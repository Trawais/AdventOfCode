#!/usr/bin/env ruby
lines = File.readlines(ARGV[0]).map(&:strip)

def get_people(lines)
  lines.map {|line| line.match(/^(\w+)/)[0] }.uniq
end

def generate_table_matrix(lines, people)
  size = people.length
  matrix = Array.new(size) { Array.new(size, 0) }
  lines.each do |line|
    line[/^(\w+) would (\w+) (\d+).*next to (\w+)[.]$/]
    first_index = people.index($1)
    second_index = people.index($4)
    value = ($2 == "gain") ? $3.to_i : (-1 * $3.to_i)
    matrix[first_index][second_index] = value
  end
  matrix
end

def eval_seating_plan(plan, happiness_matrix)
  sum = 0
  for index in (0...plan.length)
    first = plan[index]
    second = plan[(index+1) % (plan.length)]
    sum += happiness_matrix[first][second]
    sum += happiness_matrix[second][first]
  end
  sum
end

people = get_people(lines)
happiness_matrix = generate_table_matrix(lines, people)
all_seating_plans = Array(0...people.length).permutation.to_a
best_seating_plan = -Float::INFINITY

all_seating_plans.each_with_index do |plan, index|
  puts "#{index}/#{all_seating_plans.length}" if (index % 1000) == 0
  res = eval_seating_plan(plan, happiness_matrix)
  best_seating_plan = res if res > best_seating_plan
end

puts best_seating_plan
