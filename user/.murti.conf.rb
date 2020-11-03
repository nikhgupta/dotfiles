# frozen_string_literal: true

# regex separator which is commonly seen separating date fields within file names.
# saved in a variable for frequent usage later.
sp = "(?:|\.|-|_)"

# An example funtion that can be used for processing files before they are
# moved. `path` points to the file path for the file under consideration, and
# `add_file_for_migration` is a function that allows adding new files for
# consideration within runtime.
#
# ImageMagick convert and exiftool combination is used here to ensure that
# processing the same RAW file twice produces identical JPG files.
#
# Using `darktable-cli` e.g. will produce JPG files that are different slightly
# (different EXIF modification dates), and hence, is not idempotent. If for some
# reason, this processing was to run twice on same file, Murti will consider the
# two generated files as non-identical.
raw2jpg = proc do
  co = `which convert 2>/dev/null`.strip
  et = `which exiftool 2>/dev/null`.strip
  jpg_path = File.join(File.dirname(path), "#{File.basename(path, '.*')}.jpg")

  if !File.exist?(jpg_path) && !co.empty? && !et.empty?
    command = []
    command << "#{co} \"#{path}\" \"#{jpg_path}\" 2>/dev/null"
    command << "#{et} -TagsFromFile \"#{path}\" \"#{jpg_path}\" 2>/dev/null"
    command << "rm -f \"#{jpg_path}_original\" 2>/dev/null"
    success = system(command.join(' && '))
    puts "[FAIL]: #{path} => PROCESSING RAW2JPG" unless success
    add_file_for_migration jpg_path if File.exist?(jpg_path)
  else
    puts "[SKIP]: #{path} => NOT PROCESSING RAW2JPG"
  end
end

Murti.configure do
  # A group (in this case, it is the default group) which allows us to use the
  # same configuration to organize different scenarios. For example, I use
  # groups to define two different source/target combinations - one is where
  # I store my Personal data, and the other one is for Work related data.
  group do
    # Source directories are the ones where the media will be looked up for
    # organization. You can append `on: :refresh` to a source_directory to mark
    # it for organization explicitely (i.e. by passing `--refresh` switch to
    # murti cli)
    #
    # DUMP is where I dump all Images I can find, and hence, I want it to be
    # organized on each run.
    #
    # UNMATCHED is created by Murti itself when the file is not matched by any
    # of the rules defined in this config. I, may, add new rules to Murti config
    # from time to time, which is why I want this directory to be organized on
    # each run, as well.
    #
    # RAW, Videos, Pictures and Live Photos directories are created by this
    # config, and there is really no need to re-organize them (which will do
    # nothing and waste a lot of time). However, if I add a new matching rule,
    # I can use `--refresh` CLI flag to re-organize these directories.
    source_directory "#{ENV['XDG_PICTURES_DIR']}/DUMP"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/UNMATCHED"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/RAW/UNMATCHED"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Videos/UNMATCHED"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/UNMATCHED"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Documents/UNMATCHED"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Wallpapers/UNMATCHED"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Screenshots/UNMATCHED"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Live Photos/UNMATCHED"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/RAW", on: :refresh
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Videos", on: :refresh
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures", on: :refresh
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Documents", on: :refresh
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Wallpapers", on: :refresh
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Screenshots", on: :refresh
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Live Photos", on: :refresh

    # Target directory where the files will be moved/copied to.
    # `save_in` paths (specified in this config) are relative to this directory.
    target_directory (ENV['XDG_PICTURES_DIR']).to_s
  end

  group :gphotos do
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2000"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2007"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2008"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2009"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2010"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2011"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2012"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2013"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2014"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2015"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2016"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2017"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2018"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2019"
    source_directory "#{ENV['XDG_PICTURES_DIR']}/Pictures/2020"

    # Target directory where the files will be moved/copied to.
    # `save_in` paths (specified in this config) are relative to this directory.
    target_directory "#{ENV['XDG_PICTURES_DIR']}/gphotos"
  end

  # Another named group. I can ask Murti to focus on this group by passing the
  # cli option: `--group=external`
  group :external do
    source_directory '/Volumes/PICTURES/DUMP'
    source_directory '/Volumes/PICTURES/UNMATCHED'
    source_directory '/Volumes/PICTURES/RAW/UNMATCHED'
    source_directory '/Volumes/PICTURES/Videos/UNMATCHED'
    source_directory '/Volumes/PICTURES/Pictures/UNMATCHED'
    source_directory '/Volumes/PICTURES/Documents/UNMATCHED'
    source_directory '/Volumes/PICTURES/Wallpapers/UNMATCHED'
    source_directory '/Volumes/PICTURES/Screenshots/UNMATCHED'
    source_directory '/Volumes/PICTURES/Live Photos/UNMATCHED'
    source_directory '/Volumes/PICTURES/RAW', on: :refresh
    source_directory '/Volumes/PICTURES/Videos', on: :refresh
    source_directory '/Volumes/PICTURES/Pictures', on: :refresh
    source_directory '/Volumes/PICTURES/Documents', on: :refresh
    source_directory '/Volumes/PICTURES/Wallpapers', on: :refresh
    source_directory '/Volumes/PICTURES/Screenshots', on: :refresh
    source_directory '/Volumes/PICTURES/Live Photos', on: :refresh

    target_directory '/Volumes/PICTURES'
  end

  # Murti comes bundled with 3 strategies: test, move and copy.
  # By default, I would advise specifying the :test strategy within configs.
  #
  # You can override this strategy by using aptly named CLI options, and this is
  # the recommended way to run Murti. This way, you won't lose data by
  # accidently using the :move strategy with a wrong Murti configuration.
  #
  # Always see the results of `test` strategy before moving/copying files.
  # Once satisfied, I recommend the :move strategy which will ensure that your
  # files are processed just once. But, if you are paranoid or trying Murti for
  # the first time, go ahead with :copy strategy - it is non-destructive.
  use_strategy :test

  # I prefer the following folder structure, so that images are organized in
  # folders such as "2019/2019-06-19". This allows me to quickly zoom-in to
  # a given year and see an organized day-to-day view of images.
  set_date_format '%Y/%Y-%m-%d'

  # Mac creates a lot of hidden files for each image I have. Maybe, Lightroom?
  # My source directories are filled with these hidden files.
  # Here I asked Murti to skip all such hidden files, and leave them be.
  # I am anyway going to delete the leftover files, later.
  skip_if :hidden

  # I can ask Murti to skip specific extensions or only allow specific ones.
  # Oh, did I forget to tell you? This config is a Ruby DSL. You can use all
  # Ruby goodness here.
  skip_if extension_not_in: [/jpe?g/, :mp4, :mov, :ai, :psd, :png, :bmp, :gif,
                             :avi, :cr2, :webp, :tiff, :raw, :eps, :svg, :aae, :dng, :xmp]
  # skip_if extension: [/\A\z/, :pdf, :exe, :zip, :tar, :lrprev, /\Adocx?\z/]

  # Skip specific paths from organization. This is useful when we are organizing
  # a previous dump which can contain thumbnails, caches etc. which Murti can
  # look into for images and litter up by target directory.
  skip_if path: %r{/\.thumbnails?/}
  skip_if path: %r{/\.cache/\.temp/}
  skip_if path: %r{/\.cache/.*/[a-f0-9]{32}\.[^/]+\z}

  # Alright, so having specified which files I want to skip/keep, its time to
  # tell Murti how to identify timestamps from images/videos.
  #
  # Obviously, the first thing to do is to try and extract timestamps from EXIF
  # data. We use the `:occurrence` strategy which identifies EXIF dates based on
  # tags, e.g. it prefers DateTimeOriginal over DateTime/CreatedTime.
  #
  # Other options are :oldest, and :newest - which set the timestamp to the
  # oldest/newest timestamp found in any of the EXIF related fields.
  extract :timestamp, exif: :occurrence

  # If we can't find the date from EXIF data, we move on to file name/path based
  # date recognition. The first rule to match will set the timestamp for the
  # image file.
  #
  # In this case, we are looking for files with exactly 19 digits as their name.
  # This should, usually, be the unix timestamp down to nanoseconds.
  #
  # `m` contains the result of the regex match. We need to return either time,
  # date or a string (that can be parsed by Time class).
  extract :timestamp, name: %r{\A(\d{19})\.[^/]+\z} do |m|
    Time.at(m[0].to_f / 1e9)
  end

  # Same but for 13 digit files. Unix timestamp in milli-seconds.
  extract :timestamp, name: %r{\A(\d{13})\.[^/]+\z} do |m|
    Time.at(m[0].to_f / 1e3)
  end

  # More rules for extracting date-time from file names.
  # Some of them focus on whatsapp images/videos, others on iPhone generated
  # files, etc.
  extract :timestamp, name: /(\d{4})#{sp}(\d{2})#{sp}(\d{2})#{sp}(\d{2})#{sp}(\d{2})#{sp}(\d{2})#{sp}(\d+)/ do |m|
    "#{m[0]}/#{m[1]}/#{m[2]} #{m[3]}:#{m[4]}:#{m[5]}.#{m[6]}"
  end
  extract :timestamp, name: /(\d{4})#{sp}(\d{2})#{sp}(\d{2})#{sp}(\d{2})#{sp}(\d{2})#{sp}(\d{2})/ do |m|
    "#{m[0]}/#{m[1]}/#{m[2]} #{m[3]}:#{m[4]}:#{m[5]}"
  end
  extract :timestamp, name: /\A(?:IMG|VID)#{sp}(\d{4})(\d{2})(\d{2})#{sp}WA\d+/i do |m|
    "#{m[0]}/#{m[1]}/#{m[2]}"
  end
  extract :timestamp, name: /\A(?:IMG|VID)#{sp}(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})\./ do |m|
    "#{m[0]}/#{m[1]}/#{m[2]} #{m[3]}:#{m[4]}:#{m[5]}"
  end
  extract :timestamp, path: %r{/Google/(\d{4})-(\d{2})-(\d{2})(?:| \#\d+|-\d+| - \d+-\d+)/} do |m|
    "#{m[0]}/#{m[1]}/#{m[2]}"
  end
  extract :timestamp, path: %r{/\d{4}/(\d{4})-(\d{2})-(\d{2})/} do |m|
    "#{m[0]}/#{m[1]}/#{m[2]}"
  end
  extract :timestamp, path: %r{dt\.\s*(\d{2})(\d{2})(\d{4})(?:/|\.[^/]+)} do |m|
    "#{m[2]}/#{m[1]}/#{m[0]}"
  end
  extract :timestamp, name: /\A(\d{2})-(\d{2})-(\d{4})(?:_| )/ do |m|
    "#{m[2]}/#{m[1]}/#{m[0]}"
  end

  # NOT IMPLEMENTED: I wanted to implement this, but often found that this is
  # not the sensible way to organize photos. If the date can't be deduced from
  # the image exif or path, its better to send them to UNMATCHED/DUMP directory,
  # and organize them manually.
  # # extract :timestamp, file: :oldest

  # A rule specifies what to do when the file matches a given condition.
  #
  # In this particular case, we are matching the file based on Facebook naming
  # pattern, and if the file name matches this pattern, we move it to
  # <target-directory>/Pictures/Facebook.
  #
  # We are not looking to sort these files by dates - as EXIF data will not be
  # present in these files and dates can't be deduced from their names.
  rule name_regex: /\A\d{4}\d*_\d{10}\d*_\d{5}\d*_(?:n|o)(?:|_\d+)\./ do
    save_in 'Pictures/Facebook'
  end

  # Next, we want to sort iPhone generated movie files.
  #
  # We use the valid_date rule to only organize the files that have a timestamp
  # present. We, further, filter these files by name to match iPhone video files.
  #
  # For files with a valid date present, we have `%{date_format}` variable
  # available that can be used to subtitute the folder structure we specified
  # above using `set_date_format`.
  #
  # iPhone Live Photos contain a short `.MOV` file (and, I have 100s of these),
  # but the same naming pattern is used by videos I shoot on iPhone.
  #
  # Therefore, I check the file size and if its >10MB, I consider it to be
  # a video rather than a live photo, and organize accordingly.
  #
  # We will be repeating this rule later to, also, store iPhone
  # videos/live-photos where timestamp can not be found.
  rule :valid_date, name_regex: /\AIMG_\d+(?:|-\d+)\.MOV\z/i do
    size = File.stat(path).size / 1024.0 / 1024.0
    save_in(size > 10 ? 'Videos/%{date_format}' : 'Live Photos/%{date_format}')
  end

  # Next, we sort all files with `mp4`, `mov` and `avi` extension that have
  # a valid date to the `Videos` folder and arrange them as per their dates.
  rule :valid_date, extension: %i[mp4 mov avi] do
    save_in 'Videos/%{date_format}'
  end

  # I use a CANON camera. I am moving RAW images to `<target-directory>/RAW`
  # folder. Again, this rule will only match files where a timestamp was found.
  #
  # Furthermore, before moving/copying, I am interested in processing these
  # RAW files to generate a JPG file in their place. This processing won't
  # happen or show in :test mode.
  #
  # In this case, I am also interested in organizing the newly generated JPG
  # image, which is why `raw2jpg` function has a call to `add_file_for_migration`
  # which will ensure that the new file is also processed after this RAW image.
  #
  # HINT: You can use the same method to pre-process various video formats into
  # `mp4` files, and then delete the old files and organize the new `mp4` ones.
  rule :valid_date, extension: %i[cr2 raw nef] do
    migrate(&raw2jpg)
    save_in 'RAW/%{date_format}'
  end

  # Organize common image files into date folders.
  rule :valid_date, extension: [/jpe?g/, :png, :webp, :gif, :bmp, :tiff] do
    save_in 'Pictures/%{date_format}'
  end

  # This is a blank `valid_date` rule that will match any file which has
  # a timestamp deduced, but did not match any of the above rules.
  #
  # I, often, run `find` on this folder to find which extensions I missed, and
  # add those to rules in this config file.
  rule :valid_date do
    save_in 'UNKNOWN/%{date_format}'
  end

  # If a file lands up to this rule, it means that we could not find timestamp
  # for the file via its EXIF data or name. This should be common. This means
  # that we need to organize these files either based on their name alone, or we
  # should organize them manually.
  #
  # In this particular case, I am matching iPhone generated videos without
  # a timestamp to the appropriate `Videos` or `Live Photos` folder based on
  # file size.
  #
  # TODO: allow to use other exif data to organize files here, e.g. make/model
  # of the camera.
  rule name_regex: /\AIMG_\d+(?:|-\d+)\.MOV\z/i do
    size = File.stat(path).size / 1024.0 / 1024.0
    parent = size > 10 ? 'Videos' : 'Live Photos'
    save_in "#{parent}/UNMATCHED/%{path_component}"
  end

  # Convert any RAW images to JPG in their place, and move them to
  # `RAW/UNMATCHED` folder.
  #
  # `%{path_component}` can be used to create the same directory structure for
  # the file as found in the source directory.
  #
  # Therefore, if the source_directory is `/path/to/source`,
  # and RAW image was found in `/path/to/source/raw/images/1.CR2`,
  # this file will be moved to: `<target-directory>/RAW/UNMATCHED/raw/images/1.CR2`
  rule extension: %i[cr2 raw nef] do
    migrate(&raw2jpg)
    save_in 'RAW/UNMATCHED/%{path_component}'
  end

  rule extension: [:webp] do
    save_in 'Pictures/webp/%{path_component}'
  end

  # I can, also, remove/delete a matched file. Here I am deleting sidecars.
  rule extension: %i[dng xmp aae] do
    remove!
  end

  rule extension: %i[mp4 mov avi] do
    save_in 'Videos/UNMATCHED/%{path_component}'
  end

  rule extension: [/jpe?g/, :png, :webp, :gif, :bmp, :tiff] do
    save_in 'Pictures/UNMATCHED/%{path_component}'
  end

  # If a file does not match any of the above rules (which should be rare given
  # the rules I am using), it ends up in `UNMATCHED` folder.
  rule :is_unmatched do
    save_in 'UNMATCHED/%{path_component}'
  end

  # This is a special rule for duplicate files.
  #
  # If a file already exists at the new path, and is identical to the source
  # file, we will place the source file in `DUPLICATE-1/` folder with the same
  # organized path structure. On further duplicates, we store these duplicate
  # files in `DUPLICATE-*` folders.
  #
  # For example, if several files are identical to
  # `<target-directory>/organized/file.jpg`, we place them in:
  # - <target-directory>/DUPLICATE-1/organized/file.jpg
  # - <target-directory>/DUPLICATE-2/organized/file.jpg
  # - <target-directory>/DUPLICATE-3/organized/file.jpg
  # and so on..
  # You can, later, inspect these files or simply, remove them.
  #
  # However, if the target organized path is already taken and the source file
  # is a different one, we will append to the source file name. This is
  # a generic rule, and will always happen whenever the target organized path is
  # already taken. So, if several files are to occupy the same destination but
  # are individually different files, we name them as:
  # - <target-directory>/organized/file.jpg
  # - <target-directory>/organized/file-1.jpg
  # - <target-directory>/organized/file-2.jpg
  # - <target-directory>/organized/file-3.jpg
  # and so on..
  #
  # Lastly, you can also chose to simply remove these duplicate files, by using
  # `remove!`. I would recommend against this and rather remove files from
  # `DUPLICATE-*` folders.
  rule :is_duplicate do
    # remove!
    save_prefix "DUPLICATE-#{duplicate_number}"
  end
end
