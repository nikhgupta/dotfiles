#!/usr/bin/env ruby
#
# Script to download songs and metadata from Saavn.com
#

require 'pry'
require 'yaml'
require 'taglib'
require 'open-uri'
require 'mechanize'

AGENT = Mechanize.new{|a| a.user_agent_alias = 'Mac Safari'}

DOWNLOAD_DIR = "/media/JukeBox/Music/Downloaded/Saavn/320"
COOKIE = "_ga=GA1.2.1038159070.1565398002; _gid=GA1.2.2101422459.1565398002; _fp=4ed3f6ad1c2f0ac6f9ee8da781644181; __gads=ID=bd0681a834f307ed:T=1565398001:S=ALNI_Ma3i25KbFG64CErB6M7X_npiOfzYw; jwplayer.volume=75; _gat_gtag_UA_3091287_35=1; ATC=wqKtzXsWxn2ObSrzQqyA58ikrTna2X%2BBs7%2FXYy9OshvhZK890Ccv%2Bq4zUBpZANJ6"

def scrape(url, list_info={})
  page = AGENT.get(url)
  items = page.search("ol.track-list li.song-wrap")
  items = items.map do |item|
    data = data = JSON.parse item.search(".song-json").text.strip
    data = data.map{|k,v| [k.to_sym, v]}.to_h
    data[:image_url] = data[:image_url].to_s.gsub(/-\d+x\d+\./, '-500x500.')
    data[:scraped_at] = Time.now.utc.strftime("%Y-%m-%d %H:%M:%S UTC")

    if match = data[:title].match(/\A(.*)\s+\(From \&(?:#039|quot)\;(.*)\&(?:#039|quot)\;/)
      data[:title] = match[1]
      data[:album] = match[2]
    end

    if match = data[:title].match(/\A(.*)\s+\(\w+\s*\/\s*Soundtrack Version\)\z/)
      data[:title] = match[1]
    end

    path = File.join(DOWNLOAD_DIR, LANG, data[:album], "#{data[:title]}.mp3")
    next unless data[:duration].to_i >= 120 && data[:duration].to_i <= 720
    next if File.exist?(path)
    cookie = AGENT.cookies.map(&:to_s).join("; ") + "; L=#{LANG}; #{COOKIE}"

    print "#{data[:album]} / #{data[:title]} => "
    query = {url: data[:url], __call: "song.generateAuthToken", _marker: false, _format: "json", bitrate: 320}
    headers = {"content-type" => "application/x-www-form-urlencoded; charset=UTF-8", "accept" => "application/json, text/javascript, */*; q=0.01"}
    auth = JSON.parse AGENT.post('https://www.jiosaavn.com/api.php', query, headers.merge("cookie" => cookie)).body

    if auth['status'] == "success"
      # puts auth['auth_url']
      unless File.exist?(path)
        FileUtils.mkdir_p(File.dirname(path))
        AGENT.download(auth['auth_url'], path)
        write_mp3_info(path, data) if File.exist?(path)
      end
      data[:path] = path if File.exist?(path)
      puts "+"
      # sleep rand(15) + 15
    else
      puts "X"
      data
    end
  end.compact
end

def write_mp3_info(path, data)
  TagLib::MPEG::File.open(path) do |f|
    tag = f.id3v2_tag

    tag.title = data[:title]
    tag.year = data[:year].to_i
    tag.album = data[:album]
    tag.artist = data[:singers]
    tag.comment = data.to_json

    picture_data = begin
      open(data[:image_url]).read
    rescue OpenURI::HTTPError
    end

    if picture_data
      pic = TagLib::ID3v2::AttachedPictureFrame.new
      pic.picture = picture_data
      pic.mime_type = "image/jpeg"
      pic.type = TagLib::ID3v2::AttachedPictureFrame::FrontCover
      tag.add_frame(pic)
    end

    f.save
  end
end

def scrape_playlists(lang: 'hindi', size: 100)
  url = "https://www.jiosaavn.com/api.php?__call=playlist.getFeaturedPlaylists&language=#{lang}&offset=0&size=#{size}&_format=json"
  page = AGENT.get url
  lists = JSON.parse page.search("body").text
  lists['featuredPlaylists'].map do |list|
    puts "================:"
    puts "Scraping playist: #{list['listname']}(#{list['numsongs']}) @#{list['perma_url']}"
    scrape list['perma_url'], list
  end.flatten.uniq
end

items = scrape_playlists(lang: LANG, size: 100)

# convert data to csv
path = "#{ENV['HOME']}/.saavn.#{LANG}.yaml"
yaml = File.exist?(path) ? YAML.load_file(path) : []
yaml = yaml | items
File.open(path, "w") {|f| f.puts yaml.to_yaml}
unique = yaml.uniq{|a| a[:id]}.length
puts "Added #{items.length} songs. Total Unique Songs: #{unique}"
