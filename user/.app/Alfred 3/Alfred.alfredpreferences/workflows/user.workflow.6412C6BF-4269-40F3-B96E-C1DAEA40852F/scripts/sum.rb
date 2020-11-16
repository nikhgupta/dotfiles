#!/usr/bin/ruby
# From Brett Terpstra (http://brettterpstra.com/2014/04/10/a-service-for-sums-from-selections/) 
if RUBY_VERSION.to_f > 1.9
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
  input = STDIN.read.force_encoding('utf-8')
else
  input = STDIN.read
end
 
total = 0
places = 0
 
input.scan(/(\-?\d+([\.,]\d+)?)\b/).each {|x|
  total += x[0].to_f
  places = x[1].length - 1 if x[1] && x[1].length.to_i > places + 1
}
 
puts input.chomp
printf "\n%.#{places.to_i}f" % total