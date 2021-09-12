module Yabai
  module Commands
    # TODO: Command: move all spaces to their next/previous displays

    # pseduo: label a space with given index
    def label_space(space_index, label)
      run "space #{space_index} --label #{_space_label(label)}"
    end

    # command: focus on a given space
    def focus_space(space)
      run "space --focus #{_space_label(space)}"
    end

    # command: move window to a given space
    def move_window_to_space(window, space)
      run "window #{window} --space #{_space_label(space)}"
    end

    # command: move space to a given display
    def move_space_to_display(space, display)
      display_index = find_display(display: display)['index']
      run "space #{_space_label(space)} --display #{display_index}"
    end

    # command: move focus but allow moving across displays when using east or west.
    def focus_window(direction)
      run "window --focus #{direction}"
    rescue StandardError => e
      raise unless e.message.include?("could not locate a #{direction}ward managed window.")

      run "display --focus #{direction}"
    end

    # Command: swap 1st and 2nd spaces of on all displays
    def swap_context
      @state[:displays].length.times do |idx|
        first = find_space(idx + 1)
        second = find_space(idx + 1 + displays.length)

        label_space(first['index'], i + 1 + displays.length)
        label_space(second['index'], i + 1)
      end
      refocus_first_spaces
    end

    # command: update spaces to be consistent
    def update_spaces
      ensure_spaces
      refresh

      ensure_labels
      refresh

      reorganize_spaces
      remove_unnecessary_spaces
      refresh
    end

    protected

    def remove_unnecessary_spaces
      return if @state[:spaces].length <= @num_spaces

      unlabeled_spaces.each { run "space #{_1['index']} --destroy" }
    end

    def ensure_spaces
      return if @state[:spaces].length >= @num_spaces

      (@num_spaces - @state[:spaces].length).times { run 'space --create' }
    end

    def ensure_labels
      wanted = @num_spaces.times.map { _space_label(_1 + 1) }
      existing = @state[:spaces].map { _1['label'] }

      (wanted - existing).sort.each.with_index do |label, idx|
        label_space unlabeled_spaces[idx]['index'], label
      end
    end

    def refocus_first_spaces
      @state[:displays].length.times { focus_space(_1 + 1) }
    end

    def reorganize_spaces
      @state[:spaces].length.times do |idx|
        move_space_to_display idx + 1, display_for_space(idx + 1)
      end

      load[:spaces].each do |space|
        space['windows'].each do |window|
          next unless window_ids.include?(window)

          move_window_to_space(window, space['label'] == 's' ? 's1' : space['label'])
        end
      end

      # after re-shuffling, focus the "default" spaces
      refocus_first_spaces
    end
  end
end
