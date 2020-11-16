input = STDIN.read
segments = input.split(',')
items = []
count = 0
segments.each do |segment|
	if count > 0
		print ', '
	end
	name = segment.gsub(/[^A-Za-z0-9]/,'')
	print "#{name}(\"#{segment.strip}\")"
	count = count + 1
end
