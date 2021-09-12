module Yabai
  module Finders
    def unlabeled_spaces
      find_all @state[:spaces], 'label', ''
    end

    def visible_spaces
      find_all @state[:spaces], 'visible', 1
    end

    def focused_space
      find_one @state[:spaces], 'focused', 1
    end

    def display_uuids
      @state[:displays].map { _1['uuid'] }
    end

    def window_ids
      @state[:windows].map { _1['id'] }
    end

    # internal: find a display
    def find_display(display: nil, index: nil, uuid: nil)
      return find_one(@state[:displays], 'location', display) if display
      return find_one(@state[:displays], 'uuid', uuid) if uuid
      return find_one(@state[:displays], 'index', index) if index

      raise 'Must pass one of index, uuid or display'
    end

    # internal: find a space
    def find_space(space: nil, index: nil)
      return find_one(@state[:spaces], 'label', _space_label(space)) if space
      return find_one(@state[:spaces], 'index', index) if index

      raise 'Must pass one of index or space label/number'
    end

    # internal: pick a monitor setup
    def find_monitor_setup
      found = nil
      @monitors_setup.each_value do |setup|
        next if display_uuids.sort != setup.values.sort

        found = setup
        setup.values.each.with_index do |uuid, idx|
          display = find_display(uuid: uuid)
          display['location'] = idx
        end
      end
      found
    end

    # internal: decide a display for a given space
    def display_for_space(space)
      (space - 1) % @state[:displays].length
    end

    def find_all(objects, key, value)
      objects.map { _1 if _1[key] == value }.compact
    end

    def find_one(objects, key, value)
      objects.each do
        return _1 if _1[key] == value
      end
    end
  end
end
