#!/usr/bin/env ruby

require 'pry'
require 'yaml'
require 'json'
require 'socket'
require 'fileutils'

module MPV
  class JsonController

    def initialize(socket: nil, config: "#{ENV['HOME']}/.mpv-control.rc")
      @conf = YAML.load_file(config)

      @directory = @conf['directory']
      @mapping = @conf['mapping']
      @socket = UNIXSocket.new(socket || @conf['socket'])

      currently_playing
    end

    # remove media from disk
    def destroy
      exists? && FileUtils.rm_f(currently_playing)
      exists? || play_next
    end

    def tag(*colors)
      # script = "tell application \"Finder\" to set label index of alias POSIX file \"#{currently_playing}\" to #{colors[0]}"
      # puts script
      # `osascript -e '#{script}'`
      acolors = colors.map{ |col| "<string>#{col}</string>" }.join
      command = "xattr -w com.apple.metadata:_kMDItemUserTags "
      command += "'<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">"
      command += "<plist version=\"1.0\"><array>#{acolors}</array></plist>' '#{currently_playing}'"

      `#{command}`

      if @directory && @mapping.any?
        map = colors.map{ |col| @mapping[col].to_s }
        name = File.basename(currently_playing)
        new_path = File.join(@directory, map[0], name)
        puts new_path, currently_playing
        FileUtils.mv(currently_playing, new_path) if currently_playing != new_path
      end

      play_next
    end

    protected

    def currently_playing
      return @current if @current
      @current = __run(:get_property, :path)["data"]
      raise "Nothing is currently playing" if @current.to_s.empty?

      @current
    end

    def play_next
      __run :playlist_next
    end

    def exists?
      File.exists?(currently_playing)
    end

    private

    def __run(*command)
      json = { "command" => command }

      @socket.puts json.to_json
      resp = JSON.parse(@socket.readline)
      raise resp["error"] if resp["error"] != "success"

      resp
    end
  end
end

MPV::JsonController.new.send(*ARGV)
