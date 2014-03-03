require_relative '../lib/video_processor'

describe VideoProcessor do
  describe "#get_files" do
    it "returns an empty list if there are no files in the directory" do
      vp = VideoProcessor.new
      vp.get_files('./spec/video').should == []
    end

    it "returns an array of filenames" do
      vp = VideoProcessor.new
      vp.get_files('./spec/videos').should == ["./spec/videos/2006.02.20_14-92-22.dv", "./spec/videos/capture2006.02.20_14-41-17.dv"]
    end
  end

  describe "#extract_directory_and_filename" do
    vp = VideoProcessor.new
    vp.extract_directory_and_filename("./spec/videos/2006.02.20_14-92-22.dv").should == ["videos", "2006.02.20_14-92-22.dv"]
  end

  describe "#extract_base_filename" do
    it "returns filename without the extension" do
      vp = VideoProcessor.new
      vp.extract_base_filename("./spec/videos/capture2006.02.20_14-41-17.dv").should == 'capture2006.02.20_14-41-17'
    end
  end

  describe "#create_encode_command" do
    it "returns a string to encode the given file" do
      output_directory = '~/Videos/3'
      input_filename = './spec/videos/capture2006.02.20_14-41-17.dv'

      vp = VideoProcessor.new
      vp.create_encode_command(output_directory, input_filename).should == "HandBrakeCLI --preset='AppleTV 3' -i './spec/videos/capture2006.02.20_14-41-17.dv' -o '~/Videos/3/capture2006.02.20_14-41-17.mp4'"
    end
  end
end
