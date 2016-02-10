fail 'Arguments: <player_file> <boss_file>' unless ARGV.length == 2

def create_char(file)
  character_hash = {}
  File.open(file).each_line do |line|
    case line
    when /Hit Points: (\d+)/
      character_hash[:hit_points] = Regexp.last_match[1].to_i
    when /Damage: (\d+)/
      character_hash[:damage] = Regexp.last_match[1].to_i
    when /Armor: (\d+)/
      character_hash[:armor] = Regexp.last_match[1].to_i
    end
  end
  character_hash
end

player = create_char(ARGV[0])
boss = create_char(ARGV[1])

turn_number = 0
loop do
  if turn_number.even?
    boss[:hit_points] -= [player[:damage] - boss[:armor], 1].max
  else
    player[:hit_points] -= [boss[:damage] - player[:armor], 1].max
  end
  turn_number += 1
  break if (player[:hit_points] <= 0) || (boss[:hit_points] <= 0)
end

p player
p boss
