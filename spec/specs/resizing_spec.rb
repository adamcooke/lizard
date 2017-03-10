require 'spec_helper'
require 'lizard/image'

describe Lizard::Image do

  context "resizing" do
    it "should resize an image" do
      image = Lizard::Image.new(TEST_FILES[:example])
      expect(image.width).to eq 1000
      tempfile = Tempfile.new
      resized_image = image.resize(50, 50)
      expect(resized_image).to be_a(Lizard::Image)
      expect(resized_image.width).to eq 50
    end

  end
end
