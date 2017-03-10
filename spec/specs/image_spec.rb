require 'spec_helper'
require 'lizard/image'

describe Lizard::Image do

  it "should initialize from a file" do
    image = Lizard::Image.new(TEST_FILES[:example])
    expect(image).to be_a(Lizard::Image)
  end

  it "should raise an error if the properties cannot be determined" do
    expect { Lizard::Image.new(TEST_FILES[:missing]) }.to raise_error(Lizard::NotAnImage)
  end

  context "a valid RGB JPEG image" do
    before(:all) { @image = Lizard::Image.new(TEST_FILES[:example]) }

    it "should return a type" do
      expect(@image.type).to eq 'JPEG'
    end

    it "should return a resolution" do
      expect(@image.resolution).to eq '0x0'
    end

    it "should return a width, height & size" do
      expect(@image.width).to eq 1000
      expect(@image.height).to eq 500
    end

    it "should return a color space" do
      expect(@image.color_space).to eq 'DirectClass sRGB'
    end

    it "should calcualate a color model based on the color space" do
      expect(@image.color_model).to eq 'RBG'
    end
  end

  context ".is_image?" do
    it "should return true if the provided file is an image" do
      expect(Lizard::Image.is_image?(TEST_FILES[:example])).to be true
    end

    it "should return false if the provided file is not an image" do
      expect(Lizard::Image.is_image?('invaliddata')).to be false
    end
  end

end
