# + Test Abbreviation : string

ARGF.each do |line|
	line = line.strip

	type = 'Object'

	# Test Abbreviation : string
	idx = line.index(':')
	if idx
		type = line[(idx + 1)..-1].strip
		type = type[0..0].upcase + type[1..-1]
		line = line[0..(idx - 1)].strip
	end

	# Test Abbreviation
	# String
	line = line.gsub(/[^A-Za-z0-9_]/, '')
	name = line[0..0].downcase + line[1..-1]

	puts "#{type} #{name}"
end
