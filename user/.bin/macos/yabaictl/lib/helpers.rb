module Yabai
  module Helpers
    IGNORED_ERRORS = [
      'acting space is already located on the given display.',
      'cannot focus an already focused space.'
    ].freeze
    # # TODO: need to handle following errors:
    # "acting space is the last user-space on the source display and cannot be destroyed."
    # "acting space is the last user-space on the source display and cannot be moved."

    # internal: refresh internal state of windows, spaces and displays
    def refresh
      @state = @state.map { |k, _v| [k, query(k)] }.to_h
      raise 'Unidentified monitor setup' if find_monitor_setup.nil?

      save
    end

    # save current state to cache
    def save
      File.open(@cache_path, 'wb') { |f| f.puts @state.to_yaml }
    end

    # load state from cache
    def load
      YAML.load_file(@cache_path)
    end

    def run(cmd)
      stdout, stderr, status = Open3.capture3("yabai -m #{cmd}")
      return stdout if status.to_i.zero?

      if IGNORED_ERRORS.include?(stderr.strip)
        puts "While running `yabai -m #{cmd}`, we received error: #{stderr.strip}"
      else
        puts cmd if stderr.include?("value 's' is not")
        raise stderr.strip
      end
    end

    def query(domain)
      res = run "query --#{domain}"
      res ? JSON.parse(res) : {}
    end

    def _space_label(space)
      return space == 's' ? 's1' : space.to_s if space.to_s.include?('s')

      space != 's1' ? "s#{space}" : 's1'
    end
  end
end
