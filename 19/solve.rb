def get_molecules(replacements, molecule)
  molecules = []
  replacements.each do |pair|
    index = 0
    loop do
      index = molecule.index(pair.first, index)
      break unless index
      molecules << molecule[0...index] + pair[1] + molecule[(index + pair[0].length)..-1]
      index += pair[0].length
    end
  end
  molecules
end

replacements = []
medicine_molecule = ''
File.readlines(ARGV[0]).each do |line|
  if line.match(/^(\w+) => (\w+)$/)
    replacements << Regexp.last_match[1..2]
  else
    medicine_molecule = line.strip unless /\S/ !~ line
  end
end

# part 1
puts "Part 1: #{get_molecules(replacements, medicine_molecule).uniq.length}"

# part 2
replacements.map! { |e| [e[1], e[0]] } # collapsing final molecule => 'e'
steps = 0
q = [[0, medicine_molecule]] # [steps, molecule]
loop do
  q.sort! { |a, b| a[1].length - b[1].length }
  current = q.shift
  get_molecules(replacements, current[1]).uniq.each do |mol|
    if mol == 'e'
      steps = current[0] + 1
      break
    else
      q << [current[0] + 1, mol]
    end
  end
  break if q.empty?
  break unless steps == 0
end
puts "Part 2: #{steps}"
