unless ARGV.length == 2
  raise 'Two arguments are required: <limit_of_presents> {test|part1|part2}'
end
presents_limit = ARGV[0].to_i

def factors(divident)
  factors = []
  1.upto((divident**0.5).to_i) do |divisor|
    quotient, modulus = divident.divmod divisor
    factors << divisor << quotient if modulus.zero?
  end
  factors.uniq.sort
end

def presents_part_1(house)
  factors(house).inject(0) { |a, e| a + (10 * e) }
end

def presents_part_2(house)
  factors(house).inject(0) { |a, e| e * 50 >= house ? a + 11 * e : a }
end

def find_house(presents_limit)
  house_number = 1
  loop do
    presents = yield house_number
    break if presents > presents_limit
    puts "house #{house_number} => #{presents}" if house_number % 100_000 == 0
    house_number += 1
  end
  house_number
end

case ARGV[1]
when 'test'
  (1..9).each do |house|
    puts "#{house} part1 #{presents(house)}"
    puts "#{house} part2 #{presents_part_2(house)}"
  end
  exit
when 'part1'
  puts 'Part 1:', find_house(presents_limit) { |house| presents_part_1(house) }
when 'part2'
  puts 'Part 2:', find_house(presents_limit) { |house| presents_part_2(house) }
else
  raise 'Unknown action'
end
