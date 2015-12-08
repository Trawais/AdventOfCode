#!/usr/bin/env ruby
def check_vars(hash, line)
  line.split(" -> ").first.scan(/[a-z]+/).each do |var|
    return false unless hash.keys.include?(var)
  end
  return true
end

def store_var(hash, key, value)
  hash[key] = value & 65535
end

lines = File.readlines(ARGV[0]).map(&:strip!) # removes extra white spaces
vars = {}

until lines.empty?
  rest_of_lines = []
  lines.each do |line|
    if check_vars(vars, line)
      puts "line: #{line}"
      case line
      when /^([a-z0-9]+) -> ([a-z]+)$/
        vars[$2] = vars[$1] || $1.to_i
      when /^([a-z]+) LSHIFT (\d+) -> ([a-z]+)$/
        store_var(vars, $3, vars[$1] << $2.to_i)
      when /^([a-z]+) RSHIFT (\d+) -> ([a-z]+)$/
        store_var(vars, $3, vars[$1] >> $2.to_i)
      when /^([a-z0-9]+) AND ([a-z0-9]+) -> ([a-z]+)$/
        store_var(vars, $3, (vars[$1] || $1.to_i) & (vars[$2] || $2.to_i))
      when /^([a-z0-9]+) OR ([a-z0-9]+) -> ([a-z]+)$/
        store_var(vars, $3, (vars[$1] || $1.to_i) | (vars[$2] || $2.to_i))
      when /^NOT ([a-z]+) -> ([a-z]+)$/
        store_var(vars, $2, ~ vars[$1])
      else
        fail "unknown command: #{line}"
      end
    else
      rest_of_lines << line
    end
  end
  fail "It seems we are in infinite loop" if lines.count == rest_of_lines.count
  lines = rest_of_lines
  puts lines.count
  puts "---------------------------"
end

puts "Output value on wire 'a': #{vars["a"]}"
