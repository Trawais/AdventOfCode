fail 'One argument is required: <limit_of_presents>' unless ARGV.length >= 1
presents_limit = ARGV[0].to_i

def got_presents(house)
  sum = 0
  (1..house).each do |i|
    sum += i * 10 if house % i == 0
  end
  sum
end

if ARGV[1] == 'test'
  (1..9).each do |house|
    puts "#{house} got #{got_presents(house)} presents"
  end
  exit
end

#presents_limit = 100

house = 500000
loop do
  presents = got_presents(house)
  break if presents > presents_limit
  house += 1
  puts "house #{house}, presents #{presents}" if house % 1000 == 0
end

puts house
