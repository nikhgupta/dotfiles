require 'base64'
require 'digest'
require 'securerandom'
require 'active_support/core_ext/string'

class SonicBase
  ITERATIONS = 4096
  SPACE_LENGTH = 5980
  WORDLIST_FILE = "#{ENV['HOME']}/Code/plaintxt/records/wordlist.txt".freeze
  CHARSPACE_FILE = "#{ENV['HOME']}/Code/plaintxt/records/charspace.txt".freeze

  def words_list
    return @words if @words

    words = File.readlines(WORDLIST_FILE).map(&:strip)
    @words = words.select { |word| word.length >= 4 and word.length <= 8 }
  end

  def charspace
    return @charspace if @charspace

    spaces = File.read(CHARSPACE_FILE).split("\n#{'-' * 52}\n").map { |a| a.split("\n").join }
    @charspace = {
      lowers: spaces[0],
      uppers: spaces[1],
      number: spaces[2],
      symbol: spaces[3],
      supers: spaces.join
    }
  end

  def output_for(type, *args)
    if respond_to?(type)
      begin
        output = send(type, *args)
        IO.popen('pbcopy', 'w') { |pipe| pipe.print output }
        puts output
      rescue StandardError => e
        puts e.message
        exit 2
      end
    else
      puts "NoMethodError: #{type}"
      exit 1
    end
  end
end

class SonicString < SonicBase
  attr_accessor :str

  def initialize(str = '')
    self.str = str
  end

  %i[md5 sha1 sha2 sha256 sha384 sha512].each do |algo|
    define_method algo do
      Digest.const_get(algo.upcase).hexdigest(str)
    end
  end

  def encode64
    Base64.encode64(str)
  end

  def decode64
    Base64.decode64(str)
  end
end

class SonicRandomizer < SonicBase
  %i[uuid hex base64].each do |algo|
    define_method algo do |*args|
      SecureRandom.send(algo, *args)
    end
  end

  { bytes: :random_bytes, url64: :urlsafe_base64, num: :random_number, alpha: :alphanumeric }.each do |name, algo|
    define_method name do |*args|
      SecureRandom.send(algo, *args)
    end
  end

  def ascii(*args)
    len = args.length > 0 ? args[0] : 12

    arr = charspace[:supers]
    arr *= (len / arr.length + 1)
    arr.chars.shuffle(random: SecureRandom).take(len).join
  end

  def phrase(*args)
    len = args.length > 0 ? args[0] : 6

    words_list.shuffle(random: SecureRandom).take(len).join('-')
  end
end

class SonicSecret < SonicString
  def phrase
    curr = str.dup
    ITERATIONS.times.each { curr = intermediate_phrase(curr) }
    curr
  end
  alias expand phrase

  def symbols
    nums = to_int_chunks(str)
    mapping = str.chars.map { |c| c.ord % 5 }
    v = charspace.values
    mapping.map.with_index { |c, i| v[c][nums[-i - 1] % SPACE_LENGTH] }.join
  end
  alias hash symbols
  alias encode symbols

  def symphrase
    suffix = phrase
    "#{prefix_using(suffix, :uppers, :symbol, :number, :number, :symbol)} #{suffix}"
  end
  alias passphrase symphrase

  def password
    nums = to_int_chunks(str)
    words = words_list.select { |w| w.length == 4 }
    words = 2.times.map { |i| words[nums[i] % words.length] }.join('/')

    "#{prefix_using(words, :uppers, :symbol, :number, :number, :symbol)}#{words}"
  end
  alias pass password

  private

  def intermediate_phrase(salt)
    @gw ||= words_list.group_by { |i| i[0] }
    nums = to_int_chunks(str, salt)

    str.downcase.chars.map.with_index do |c, i|
      @gw[c] ? @gw[c][nums[i] % @gw[c].length] : c
    end.join(' ').strip
  end

  def prefix_using(words, *seq)
    nums = to_int_chunks(str, words)
    seq.map.with_index { |s, i| char_from(s, nums[-i - 1]) }.join
  end

  def char_from(name, int)
    charspace[name][int % SPACE_LENGTH]
  end

  def to_int_chunks(str, salt = '')
    str = "#{str.downcase} :: #{Digest::SHA512.hexdigest(str.downcase)} :: #{salt}"
    Digest::SHA512.hexdigest(str).scan(/.{4}/).map { |i| i.to_i(16) }
  end
end
