require 'pry'
require 'json'
require 'yaml'
require 'optparse'
require 'open3'

require_relative './lib/helpers'
require_relative './lib/finders'
require_relative './lib/commands'

module Yabai
  class Controller
    include Yabai::Helpers
    include Yabai::Finders
    include Yabai::Commands

    def initialize(monitors:, spaces_count: 10)
      @num_spaces = spaces_count
      @cache_path = "#{ENV['HOME']}/.cache/yabaictl"
      @state = { spaces: [], displays: [], windows: [] }
      @monitors_setup = monitors

      FileUtils.mkdir_p(File.dirname(@cache_path))
      refresh
    end

    def inspect
      "#<YabaiControl:#{to_h} @num_spaces=#{@num_spaces} @cache_path=#{@cache_path} @state=...>"
    end

    def pry
      binding.pry
    end
  end
end
