#!/usr/bin/env ruby
def total_score(ingredients, variant)
  total_score = 1
  (0..3).each do |ingredient|
    property_sum = 0
    variant.each_index do |index|
      property_sum += ingredients[index][ingredient] * variant[index]
    end
    property_sum = property_sum > 0 ? property_sum : 0
    total_score *= property_sum
  end
  total_score
end

def exact_calories?(ingredients, variant, given_calories)
  calories = 0
  variant.each_index do |index|
    calories += ingredients[index][-1] * variant[index]
  end
  calories == given_calories ? true : false
end

fail 'One parameter is required: <input_file>' unless ARGV.length == 1
input_file = ARGV.shift

ingredients = []
File.open(input_file, 'r').each_line do |line|
  line[/(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/]
  ingredients << Regexp.last_match.to_a[2..6].map(&:to_i)
end

best_cookie = 0
best_500cal_cookie = 0
Array(0..100).repeated_combination(ingredients.length).to_a
  .select { |a| a.inject(:+) == 100 }.each do |hundred|
  hundred.permutation.to_a.each do |variant|
    score = total_score(ingredients, variant)
    best_cookie = score if score > best_cookie
    best_500cal_cookie = score if exact_calories?(ingredients, variant, 500) &&
                                  score > best_500cal_cookie
  end
end

puts best_cookie
puts best_500cal_cookie
