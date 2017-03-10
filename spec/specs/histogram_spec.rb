require 'spec_helper'
require 'lizard/image'

describe Lizard::Image do

  it "should have a histogram" do
    image = Lizard::Image.new(TEST_FILES[:example])
    expect(image.histogram).to be_a(Lizard::Histogram)
    expect(image.histogram.colors).to be_a(Array)
    expect(image.histogram.colors).to all(be_a(Lizard::Color))
  end

end
