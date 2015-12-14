#!/usr/bin/env ruby
content = File.read(ARGV[0])

def sum_all_numbers(content)
  content.scan(/[-]?\d+/).inject(0) {|sum, item| sum += item.to_i }
end

def left_end(content, index)
  swallow_counter = 0
  loop do
    index -= 1
    case content[index]
    when '}'
      swallow_counter += 1
    when '{'
      if swallow_counter == 0
        break
      else
        swallow_counter -= 1
      end
    end
    break if index == 0
  end
  index
end

def right_end(content, index)
  swallow_counter = 0
  loop do
    index += 1
    case content[index]
    when '{'
      swallow_counter += 1
    when '}'
      if swallow_counter == 0
        break
      else
        swallow_counter -= 1
      end
    end
    break if index >= content.length
  end
  index
end

def in_array?(content, index)
  swallow_counter = 0
  box_counter = 0
  loop do
    index += 1
    case content[index]
    when '{'
      swallow_counter += 1
    when '}'
      if swallow_counter == 0
        return false
      else
        swallow_counter -= 1
      end
    when '['
      box_counter += 1
    when ']'
      if box_counter == 0
        return true
      else
        box_counter -= 1
      end
    end
    break if index >= content.length
  end
end

def remove_red_objects(content)
  content = content.clone
  while index = content.index('red')
    if in_array?(content, index)
      content[index] = 'X'
    else
      left_index = left_end(content, index)
      right_index = right_end(content, index)
      content = content[0..left_index] + content[right_index..-1]
    end
  end
  content
end

# part 1
puts "Part 1: #{sum_all_numbers(content)}"

# part 2
puts "Part 2: #{sum_all_numbers(remove_red_objects(content))}"
