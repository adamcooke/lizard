require 'spec_helper'
require 'lizard/image'

describe Lizard::Image do

  context "cropping" do
    it "should crop an image" do
      image = Lizard::Image.new(TEST_FILES[:example])
      expect(image.width).to eq 1000
      tempfile = Tempfile.new
      cropped_image = image.crop(500, 200)
      expect(cropped_image).to be_a(Lizard::Image)
      expect(cropped_image.width).to eq 500
      expect(cropped_image.height).to eq 200
    end

  end
end
