class VideoProcessor
  def get_files(directory, extension = 'dv')
    Dir.glob("#{directory}/**/*.#{extension}")
  end

  def create_directories(input_directory, output_directory)
    dirs = Dir.glob("#{input_directory}/**/*").select { |f| File.directory? f}.map { |d| "mkdir -p '#{d.gsub(/#{input_directory}/, "#{output_directory}")}'" }
  end

  def extract_base_filename(filename)
    dir, f = extract_directory_and_filename(filename)
    f.split('.dv').first
  end

  def extract_directory_and_filename(path)
    p = path.split('/')

    filename = p.last
    dir = p.length >= 2 ? p[p.length - 2] : ''
    [ dir, filename ]
  end

  def create_encode_command(output_directory, input_filename)
    base_filename = extract_base_filename(input_filename)

    "HandBrakeCLI --preset='AppleTV 3' -i '#{input_filename}' -o '#{output_directory}/#{base_filename}.mp4'"
  end
end
