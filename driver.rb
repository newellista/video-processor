require './lib/video_processor'
require 'optparse'

options = {}

optparse = OptionParser.new do |opts|

  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end

  options[:input_directory] = './movies'
  opts.on( '-i', '--input-directory DIRECTORY', "Directory containing videos to convert") do |i|
    options[:input_directory] = i
  end

  options[:output_directory] = './converted_movies'
  opts.on( '-o', '--output-directory DIRECTORY', "Directory to put converted videos") do |i|
    options[:output_directory] = i
  end
end

optparse.parse!

vp = VideoProcessor.new

files = vp.get_files(options[:input_directory])

files.each do |f|
  dir, filename = vp.extract_directory_and_filename(f)
  puts vp.create_encode_command("#{options[:output_directory]}/#{dir}", f)
end
