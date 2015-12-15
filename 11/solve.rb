#!/usr/bin/env ruby
def next_password(password)
  new_password = password.next
  new_password[0..7]
end

def triple?(password)
  Array('a'..'x').each do |i|
    return true if password.include?("#{i}#{i.next}#{i.next.next}")
  end
  false
end

def no_forbiden_char?(password)
  return true unless /[iol]/ =~ password
  false
end

def two_pairs?(password)
  return true if password.scan(/((\w)\2)/).uniq.count >= 2
  false
end

def valid_password?(password)
  triple?(password) && no_forbiden_char?(password) && two_pairs?(password)
end

# original_password = 'hxbxwxba'
password = 'hxbxxyzz'
loop do
  password = next_password(password)
  break if valid_password?(password)
end

puts "New Santa's password: #{password}"

# p valid_password?('hijklmmn') # false
# p valid_password?('abbceffg') # false
# p valid_password?('abbcegjk') # false
# p valid_password?('abcdefgh') # false
# p valid_password?('abcdffaa') # true
# p valid_password?('ghijklmn') # false
# p valid_password?('ghjaabcc') # true
