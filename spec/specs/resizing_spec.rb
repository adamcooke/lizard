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

    it "should not resize up by default" do
      image = Lizard::Image.new(TEST_FILES[:example])
      expect(image.width).to eq 1000
      tempfile = Tempfile.new
      resized_image = image.resize(5000, 5000)
      expect(resized_image).to be_a(Lizard::Image)
      expect(resized_image.width).to eq 1000
    end

    it "should resize with fill" do
      image = Lizard::Image.new(TEST_FILES[:example])
      expect(image.width).to eq 1000
      tempfile = Tempfile.new
      resized_image = image.resize(100, 100, :fill)
      expect(resized_image).to be_a(Lizard::Image)
      expect(resized_image.width).to eq 200
      expect(resized_image.height).to eq 100
    end

    it "should resize with ignoring aspect ratio" do
      image = Lizard::Image.new(TEST_FILES[:example])
      expect(image.width).to eq 1000
      tempfile = Tempfile.new
      resized_image = image.resize(100, 100, :ignore_aspect)
      expect(resized_image).to be_a(Lizard::Image)
      expect(resized_image.width).to eq 100
      expect(resized_image.height).to eq 100
    end

  end
end
